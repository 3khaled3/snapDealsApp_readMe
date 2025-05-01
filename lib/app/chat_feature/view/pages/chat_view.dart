import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_messages_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_icon_button.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_bubble.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/recording_button.dart';
import 'package:snap_deals/app/chat_feature/data/services/determine_position.dart';

part 'send_bar_widget.dart';
part 'messages_builder.dart';

class ChatView extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatView({super.key, required this.chatRoom});
  static String route = "/ChatView";

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    // requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Room')),
      body: Column(
        children: [
          Expanded(child: MessagesBuilder()),
          SendBar(chatRoomId: widget.chatRoom.id),
        ],
      ),
    );
  }
}
//todo remove permission from here
