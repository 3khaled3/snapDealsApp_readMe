import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_app_bar.dart';
import 'package:snap_deals/app/search_feature/view/widget/empty_widget.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_ticket_widget.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

class ChatTicketsView extends StatelessWidget {
  static const routeName = '/chat_tickets_view';
  final ChatConfig chatConfig;

  const ChatTicketsView({
    super.key,
    required this.chatConfig,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomCubit, List<ChatRoom>>(
      builder: (context, chatRooms) {
        if (chatRooms.isEmpty) {
          return Center(
            child: EmptyWidget(
              text: context.tr.noChatsAvailable,
              // style: AppTextStyles.medium16().copyWith(color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          itemCount: chatRooms.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) {
            final chatRoom = chatRooms[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ChatTicketWidget(
                chatRoom: chatRoom,
                chatConfig: chatConfig,
              ),
            );
          },
        );
      },
    );
  }
}
