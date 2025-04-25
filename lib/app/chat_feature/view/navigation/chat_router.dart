//handle go router
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_messages_cubit.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_tickets_view.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';

abstract class ChatRouter {
  static final List<GoRoute> routes = [
    GoRoute(
        path: ChatView.route,
        builder: (context, state) {
          final chatRoom = state.extra as ChatRoom;
          return BlocProvider.value(
            value: ChatMessagesCubit(chatRoom: chatRoom),
            child: ChatView(chatRoom: chatRoom),
          );
        }),
    GoRoute(
        path: ChatTicketsView.routeName,
        builder: (context, state) => BlocProvider.value(
              value: ChatRoomCubit(),
              child: const ChatTicketsView(),
            )),
  ];
}
