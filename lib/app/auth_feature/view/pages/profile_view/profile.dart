import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/view/pages/access_users.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/settings.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/your_profile.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_bottom_sheet.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/repositories/chat_room_repository.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_products_views.dart';
import 'package:snap_deals/app/request_feature/view/pages/my_request_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:uuid/uuid.dart';

class ProfileViewArgs {
  //todo add any parameters you need
}

class ProfileView extends StatelessWidget {
  const ProfileView({this.args, super.key});
  final ProfileViewArgs? args;
  static const String routeName = '/home_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileStates>(
        bloc: ProfileCubit.instance,
        builder: (context, state) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 90),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: CachedNetworkImage(
                    imageUrl:
                        ProfileCubit.instance.state.profile.profileImg ?? "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                    placeholder: (context, url) => SvgPicture.asset(
                      AppImageAssets.defaultProfile,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      AppImageAssets.defaultProfile,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),

                12.ph,
                Text(
                  ProfileCubit.instance.state.profile.name,
                  style: AppTextStyles.semiBold24().copyWith(
                    fontFamily: context.tr.fontFamilyLora,
                  ),
                ),
                30.ph,

                /// Profile Options List
                Column(
                  children: [
                    CustomListTile(
                      leadingIcon: Icons.person_2_outlined,
                      title: context.tr.yourProfile,
                      onTap: () =>
                          GoRouter.of(context).push(YourProfileView.routeName),
                    ),
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.subdirectory_arrow_right_outlined,
                      title: context.tr.aboutUs,
                      onTap: () =>
                          GoRouter.of(context).push(AboutUsView.routeName),
                    ),
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.request_page_outlined,
                      title: context.tr.my_requests,
                      onTap: () =>
                          GoRouter.of(context).push(MyRequestView.routeName),
                    ),
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.shopping_cart_outlined,
                      title:
                          '${context.tr.my_products} & ${context.tr.my_courses}',
                      onTap: () =>
                          GoRouter.of(context).push(MyProductsViews.routeName),
                    ),
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.password_outlined,
                      title: context.tr.passwordManager,
                      onTap: () =>
                          CustomBottomSheet.showPasswordManagerSheet(context),
                    ),
                    if (ProfileCubit.instance.state.profile.role ==
                        Role.user) ...[
                      12.ph,
                      CustomListTile(
                        leadingIcon: Icons.support_agent,
                        title: context.tr.contactSupport,
                        onTap: () => navigateToChatSupport(context),
                      ),
                    ],
                    if (ProfileCubit.instance.state.profile.role ==
                        Role.admin) ...[
                      12.ph,
                      CustomListTile(
                        leadingIcon: Icons.person_search_rounded,
                        title: context.tr.accessUsers,
                        onTap: () =>
                            GoRouter.of(context).push(AccessUsers.routeName),
                      ),
                    ],
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.settings_outlined,
                      title: context.tr.Settings,
                      onTap: () =>
                          GoRouter.of(context).push(SettingsView.routeName),
                    ),
                    12.ph,
                    CustomListTile(
                      leadingIcon: Icons.logout_outlined,
                      title: context.tr.logOut,
                      onTap: () => CustomBottomSheet.showLogoutSheet(context),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

spaceBetweenListTile() {
  return Container(
    width: double.infinity,
    height: 2,
    color: Colors.grey.shade300,
  );
}

Future<void> navigateToChatSupport(BuildContext context) async {
  // final GetSupUserCubit instance = GetSupUserCubit();
  // instance.getSupUser(userID);

  // Show a dialog to handle the waiting state
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final chatRooms = await ChatRoomRepository(
            chatConfig: ChatConfig.fromType(ChatType.support))
        .getSupportChatRooms();
    // Navigator.of(context).pop();
    chatRooms.fold(
      (left) {
        log("left: ${left.toString()}");
        _createAndNavigateToChat(context);
      },
      (right) {
        if (right.isEmpty) {
          _createAndNavigateToChat(context);
        } else {
          log("right: ${right.first.toJson()}");
          GoRouter.of(context).push(ChatView.route,
              extra: ChatViewArgs(
                chatType: ChatType.support,
                chatRoom: right.first,
                partner: Partner(
                  id: "Support",
                  name: "Support",
                  role: Role.admin,
                  notificationToken: "",
                ),
              ));
        }
      },
    );
  });
}

void _createAndNavigateToChat(BuildContext context) {
  final id = const Uuid().v4();

  ChatRoom chatRoom = ChatRoom(
    id: id,
    members: [ProfileCubit.instance.state.profile.id, "Support"],
    unreadMessagesCount: {},
    lastMessageId: "muck",
    lastMessageContent: "muck",
    lastMessageSender: "muck",
    lastMessageTimestamp: 0,
  );

  GoRouter.of(context).push(
    ChatView.route,
    extra: ChatViewArgs(
      chatRoom: chatRoom,
      partner: Partner(
        id: id,
        name: "Support",
        role: Role.admin,
        notificationToken: "",
      ),
      chatType: ChatType.support,
    ),
  );
}
