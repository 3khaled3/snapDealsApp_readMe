//handle go router
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_messages_cubit.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_tickets_view.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';

abstract class ChatRouter {
  static final List<GoRoute> routes = [
    GoRoute(
        path: ChatView.route,
        builder: (context, state) {
          final args = state.extra as ChatViewArgs;
          return BlocProvider.value(
            value: ChatMessagesCubit(
                chatConfig: ChatConfig.fromType(args.chatType),
                chatRoom: args.chatRoom,
                partner: args.partner),
            child: ChatView(args: args),
          );
        }),
    GoRoute(
        path: ChatTicketsView.routeName,
        builder: (context, state) {
          final args = state.extra as ChatConfig;
          return BlocProvider.value(
            value: ChatRoomCubit(chatConfig: args),
            child: ChatTicketsView(chatConfig: args),
          );
        }),
  ];
}
