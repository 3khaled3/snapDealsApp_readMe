import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_messages_cubit.dart';
import 'package:snap_deals/app/chat_feature/model_view/send_bar_helper.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_view_app_bar.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_bubble.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/recording_button.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

import '../../data/models/chat_config.dart';
part 'send_bar_widget.dart';
part 'messages_builder.dart';

class ChatViewArgs {
  final ChatRoom chatRoom;
  final Partner partner;
  final ChatType chatType;

  ChatViewArgs(
      {required this.chatRoom, required this.partner, required this.chatType});
}

class ChatView extends StatelessWidget {
  final ChatViewArgs args;
  const ChatView({super.key, required this.args});
  static String route = "/ChatView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xff0052cc),
        child: SafeArea(
          child: Column(
            children: [
              ChatViewAppBar(partner: args.partner),
              Expanded(
                child: Material(
                  color: const Color(0xFFF9FAFB),
                  child: Column(
                    children: [
                      Expanded(
                          child: MessagesBuilder(chatRoomId: args.chatRoom.id)),
                      SendBar(chatRoomId: args.chatRoom.id),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
