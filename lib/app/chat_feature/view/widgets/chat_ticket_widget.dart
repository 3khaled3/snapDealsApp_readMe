import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/chat_feature/model_view/get_sup_user_cubit/get_sup_user_cubit.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';

import 'package:shimmer/shimmer.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
part 'shimmer_effect_for_ticket.dart';

class ChatTicketWidget extends StatelessWidget {
  const ChatTicketWidget({
    super.key,
    required this.chatRoom,
    required this.chatConfig,
  });
  final ChatRoom chatRoom;
  final ChatConfig chatConfig;

  @override
  Widget build(BuildContext context) {
    final GetSupUserCubit getSupUserCubit = GetSupUserCubit();
    getSupUserCubit.getSupUser(chatRoom.members
        .where((e) => e != ProfileCubit.instance.state.profile.id)
        .first);

    final String dataTime = DateFormat('h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(chatRoom.lastMessageTimestamp),
    );

    late int unreadMessagesCount;
    if (ProfileCubit.instance.state.profile.role == Role.admin) {
      unreadMessagesCount = chatRoom.unreadMessagesCount["admin"] ?? 0;
    } else {
      unreadMessagesCount = chatRoom
              .unreadMessagesCount[ProfileCubit.instance.state.profile.id] ??
          0;
    }
    return BlocBuilder<GetSupUserCubit, GetSupUserState>(
      bloc: getSupUserCubit,
      builder: (context, state) {
        if (state is GetSupUserLoading) {
          return _buildShimmerEffect();
        }
        if (state is GetSupUserError) {
          // return Center(child: Text(state.message));
        }
        if (state is GetSupUserSuccess) {
          final user = state.user;
          return InkWell(
            onTap: () {
              GoRouter.of(context).push(ChatView.route,
                  extra: ChatViewArgs(
                    chatRoom: chatRoom,
                    partner: user,
                    chatType: ChatConfig.getChatType(chatConfig),
                  ));
            },
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                color: ColorsBox.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ColorsBox.grey.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: CachedNetworkImage(
                      imageUrl: user.profileImg ?? " ",
                      placeholder: (context, url) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bold20(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chatRoom.lastMessageContent,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regular16().copyWith(
                            color: ColorsBox.mainColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        dataTime,
                        style: AppTextStyles.regular14().copyWith(
                          color: ColorsBox.grey700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (unreadMessagesCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ColorsBox.mainColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            unreadMessagesCount.toString(),
                            style: AppTextStyles.bold12().copyWith(
                              color: ColorsBox.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
