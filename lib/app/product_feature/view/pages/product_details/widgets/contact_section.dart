import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/repositories/chat_room_repository.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:uuid/uuid.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.user});
  final Partner user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.ownerInformation,
                style: AppTextStyles.semiBold16(),
              ),
              6.ph,
              Text(
                user.name,
                style: AppTextStyles.medium16()
                    .copyWith(color: ColorsBox.blueGrey),
              ),
              15.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomPrimaryButton(
                      title: context.tr.callWord,
                      onTap: () {},
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: CustomPrimaryButton(
                      title: context.tr.ChatWord,
                      onTap: () async {
                        print(
                            "id0 ProfileCubit : ${ProfileCubit.instance.state.profile.id}");

                        final chatRooms = await ChatRoomRepository()
                            .getSpecificChatRooms("0000");
                        chatRooms.fold((left) {
                          final id = const Uuid().v4();

                          ChatRoom chatRoom = ChatRoom(
                            id: id,
                            members: [
                              ProfileCubit.instance.state.profile.id,
                              "0000"
                            ],
                            unreadMessagesCount: {},
                            lastMessageId: "muck",
                            lastMessageContent: "muck",
                            lastMessageSender: "muck",
                            lastMessageTimestamp: 0,
                          );
                          GoRouter.of(context)
                              .push(ChatView.route, extra: chatRoom);
                        }, (right) {
                          print("right: $right");
                          if (right.isEmpty) {
                            final id = const Uuid().v4();
                            ChatRoom chatRoom = ChatRoom(
                              id: id,
                              members: [
                                ProfileCubit.instance.state.profile.id,
                                "0000"
                              ],
                              unreadMessagesCount: {},
                              lastMessageId: "muck",
                              lastMessageContent: "muck",
                              lastMessageSender: "muck",
                              lastMessageTimestamp: 0,
                            );
                            GoRouter.of(context)
                                .push(ChatView.route, extra: chatRoom);
                          } else {
                            GoRouter.of(context)
                                .push(ChatView.route, extra: right.first);
                          }
                        });
                      },
                      isWhite: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
