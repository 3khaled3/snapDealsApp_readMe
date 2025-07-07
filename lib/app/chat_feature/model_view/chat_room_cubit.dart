import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';

import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';

import '../data/models/chat_config.dart';

class ChatRoomCubit extends Cubit<List<ChatRoom>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? _chatRoomsSubscription;
  late final Box<ChatRoom> _chatRoomBox;
  late final VoidCallback _hiveListener;
  final ChatConfig chatConfig;

  ChatRoomCubit({required this.chatConfig}) : super([]) {
    _initHive();
  }

  // Initialize Hive and listen for changes
  Future<void> _initHive() async {
    try {
      _chatRoomBox = Hive.box<ChatRoom>(chatConfig.chatRoomsCollection);
      _hiveListener = _updateStateFromHive;
      _chatRoomBox.listenable().addListener(_hiveListener);
      _updateStateFromHive();
      _listenToChatRooms();
    } catch (e) {
      print("Error initializing Hive: $e");
    }
  }

  // Update state from Hive box
  void _updateStateFromHive() {
    if (isClosed) return; emit(_chatRoomBox.values.toList());
  }

  // Listen to Firestore for real-time chat room updates
  Future<void> _listenToChatRooms() async {
    final currentUser = ProfileCubit.instance.state.profile;
    String currentID = currentUser.id;

    if (currentUser.role == Role.admin) {
      currentID = "Support";
    }
    print(
        "currentUser: $currentID userType: ${chatConfig.chatRoomsCollection}");

    // Ensure previous listener is canceled before starting a new one
    await _chatRoomsSubscription?.cancel();

    _chatRoomsSubscription = _firestore
        .collection(chatConfig.chatRoomsCollection)
        .where("members", arrayContainsAny: [currentID])
        .snapshots()
        .listen(
          (snapshot) {
            for (final doc in snapshot.docs) {
              final chatRoom = ChatRoom.fromJson(doc.data());
              _chatRoomBox.put(chatRoom.id, chatRoom);
            }
          },
          onError: (error) {
            print("Error listening to chat rooms: $error");
          },
        );
  }

  // Add a new chat room to Firestore and Hive
  Future<void> addChatRoom(ChatRoom chatRoom) async {
    try {
      await _firestore
          .collection(chatConfig.chatRoomsCollection)
          .doc(chatRoom.id)
          .set(chatRoom.toJson());
      _chatRoomBox.put(chatRoom.id, chatRoom);
    } catch (e) {
      print("Error adding chat room: $e");
    }
  }

  @override
  Future<void> close() async {
    await _chatRoomsSubscription?.cancel(); // Cancel Firestore subscription
    _chatRoomBox.listenable().removeListener(_hiveListener); // Remove listener
    return super.close();
  }
}
