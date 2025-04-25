import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_app_bar.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_ticket_widget.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class ChatTicketsView extends StatelessWidget {
  static const routeName = '/chat_tickets_view';

  const ChatTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: ChatAppBar(title: context.tr.ChatWord),
      ),
      body: BlocBuilder<ChatRoomCubit, List<ChatRoom>>(
        builder: (context, chatRooms) {
          return ListView.builder(
            itemCount: chatRooms.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ChatTicketWidget(chatRoom: chatRoom),
              );
            },
          );
        },
      ),
    );
  }
}
