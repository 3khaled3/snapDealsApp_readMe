import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_tickets_view.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/chat_app_bar.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ChatWrapper extends StatelessWidget {
  const ChatWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = ProfileCubit.instance.state.profile.role == Role.admin;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: ChatAppBar(title: context.tr.ChatWord),
      ),
      body: DefaultTabController(
        length: isAdmin ? 2 : 1,
        child: Column(
          children: [
            if (isAdmin) ChatTabBar(isAdmin: isAdmin),
            Expanded(child: ChatTabBarView(isAdmin: isAdmin)),
          ],
        ),
      ),
    );
  }
}

class ChatTabBar extends StatelessWidget {
  final bool isAdmin;
  const ChatTabBar({super.key, required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: TabBar(
        tabs: isAdmin
            ? const [
                TabChild(title: "Chat as Support"),
                TabChild(title: "Chat as User"),
              ]
            : const [
                TabChild(title: "Chat"),
              ],
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorsBox.mainColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: ColorsBox.white,
        unselectedLabelColor: ColorsBox.mainColor,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashBorderRadius: BorderRadius.circular(100),
        dividerColor:
            Colors.transparent, // <- removes bottom divider (Flutter 3.10+)
      ),
    );
  }
}

class ChatTabBarView extends StatelessWidget {
  final bool isAdmin;
  const ChatTabBarView({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return !isAdmin
        ? BlocProvider(
            create: (_) =>
                ChatRoomCubit(chatConfig: ChatConfig.fromType(ChatType.free)),
            child:
                ChatTicketsView(chatConfig: ChatConfig.fromType(ChatType.free)),
          )
        : TabBarView(
            children: [
              BlocProvider(
                create: (_) => ChatRoomCubit(
                    chatConfig: ChatConfig.fromType(ChatType.support)),
                child: ChatTicketsView(
                    chatConfig: ChatConfig.fromType(ChatType.support)),
              ),
              BlocProvider(
                create: (_) => ChatRoomCubit(
                    chatConfig: ChatConfig.fromType(ChatType.free)),
                child: ChatTicketsView(
                    chatConfig: ChatConfig.fromType(ChatType.free)),
              ),
            ],
          );
  }
}

class TabChild extends StatelessWidget {
  final String title;
  const TabChild({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: ColorsBox.mainColor, width: 2),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: AppTextStyles.bold16(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
