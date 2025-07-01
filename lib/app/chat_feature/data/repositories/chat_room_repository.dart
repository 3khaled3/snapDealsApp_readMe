import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';

import 'package:snap_deals/core/constants/constants.dart';
import 'package:snap_deals/core/utils/failure_model.dart';
import 'package:snap_deals/core/utils/network_utils.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/core/utils/network_utils.dart';

class ChatRoomRepository {
  final ChatConfig chatConfig;

  ChatRoomRepository({
    required this.chatConfig,
  });
  Future<Either<Failure, List<ChatRoom>>> getChatRooms() async {
    return await FirebaseUtils.handleRequest(() async {
      final currentUser = ProfileCubit.instance.state.profile.id;
      final result = await FirebaseFirestore.instance
          .collection(chatConfig.chatRoomsCollection)
          .where("members.$currentUser", isEqualTo: currentUser)
          .get();
      return result.docs.map((e) => ChatRoom.fromJson(e.data())).toList();
    });
  }


  Future<Either<Failure, List<ChatRoom>>> getSpecificChatRooms(
      String salonId) async {
    return await FirebaseUtils.handleRequest(() async {
      final currentUser = ProfileCubit.instance.state.profile.id;
      print("right:  members currentUser: $currentUser salonId: $salonId");
      final result = await FirebaseFirestore.instance
      
          .collection(chatConfig.chatRoomsCollection)
          .where("members", arrayContainsAny: [currentUser]).get();
      return result.docs
          .map((e) => ChatRoom.fromJson(e.data()))
          .toList()
          .where((e) => e.members.contains(salonId))
          .toList();
    });
  }

  Future<Either<Failure, List<ChatRoom>>> getSupportChatRooms() async {
    return await FirebaseUtils.handleRequest(() async {
      final currentUser = ProfileCubit.instance.state.profile.id;
      final result = await FirebaseFirestore.instance
          .collection(chatConfig.chatRoomsCollection)
          .where("members", arrayContainsAny: [currentUser]).get();
      return result.docs
          .map((e) => ChatRoom.fromJson(e.data()))
          .toList()
          .where((e) => e.members.contains("Support"))
          .toList();
    });
  }

  Future<Either<Failure, void>> setChatRooms(ChatRoom chatRoom) async {
    print("setChatRooms");
    return await FirebaseUtils.handleRequest(
      () async {
        return await FirebaseUtils.addDocument(
            documentId: chatRoom.id,
            collectionPath: chatConfig.chatRoomsCollection,
            data: chatRoom.toJson());
      },
    );
  }

  Future<Either<Failure, void>> updateChatRooms(
      String documentId, Map<String, dynamic> data) async {
    return await FirebaseUtils.handleRequest(
      () async {
        return await FirebaseUtils.updateDocument(
            collectionPath: chatConfig.chatRoomsCollection,
            data: data,
            documentId: documentId);
      },
    );
  }
}
