import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/chat_feature/model_view/get_sup_user_cubit/get_sup_user_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_products_views.dart';
import 'package:snap_deals/app/request_feature/view/pages/my_request_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

import '../../product_feature/view/pages/product_details/widgets/contact_section.dart';
import '../view_model/cubit/notification_cubit.dart';
import 'widget/notification_widget.dart';

part 'widget/delete_all_dialog.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  static String route = "/NotificationsView";

  @override
  Widget build(BuildContext context) {
    final notificationCubit = NotificationCubit();
    notificationCubit.fetchNotifications();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<NotificationCubit, NotificationState>(
              bloc: notificationCubit,
              builder: (context, state) {
                if (state is NotificationLoaded &&
                    state.notifications.isNotEmpty) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
                            child: CustomBackButton(),
                          ),
                          16.pw,
                          Center(
                            child: Text(
                              context.tr.notifications,
                              style: AppTextStyles.semiBold20().copyWith(
                                fontFamily: context.tr.fontFamilyLora,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => notificationCubit.markAllAsSeen(),
                            icon: const Icon(Icons.done_all,
                                color: ColorsBox.mainColor),
                            tooltip: context.tr.mark_all_as_read,
                          ),
                          8.pw,

                          // Delete All Button with Confirmation
                          IconButton(
                            onPressed: () => _showDeleteConfirmationDialog(
                                context, notificationCubit),
                            icon:
                                const Icon(Icons.delete, color: ColorsBox.red),
                            tooltip: context.tr.delete_all,
                          ),
                        ],
                      ),
                      12.ph,
                      const Divider(
                        color: ColorsBox.greyishTwo,
                        height: 1,
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: CustomBackButton(),
                        ),
                        16.pw,
                        Center(
                          child: Text(
                            context.tr.notifications,
                            style: AppTextStyles.semiBold20().copyWith(
                              fontFamily: context.tr.fontFamilyLora,
                            ),
                          ),
                        ),
                      ],
                    ),
                    12.ph,
                    const Divider(
                      color: ColorsBox.greyishTwo,
                      height: 1,
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                bloc: notificationCubit,
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotificationLoaded) {
                    if (state.notifications.isEmpty) {
                      return Center(
                        child: Text(
                          context.tr.no_notifications,
                          style: AppTextStyles.medium18()
                              .copyWith(color: ColorsBox.grey700),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.notifications.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];

                        return NotificationWidget(
                          key: ValueKey(notification.id),
                          notification: notification,
                          onMarkAsSeen: () async {
                            if (!notification.isSeen) {
                              notificationCubit.markAsSeen(notification.id);
                            }
                            if (notification.title == 'chat') {
                              GetSupUserCubit getSupUserCubit =
                                  GetSupUserCubit();
                              getSupUserCubit.getSupUser(notification.senderId);
                              if (getSupUserCubit.state is GetSupUserSuccess) {
                                Partner partner =
                                    (getSupUserCubit.state as GetSupUserSuccess)
                                        .user;
                                startChat(
                                    context,
                                    Partner(
                                      id: partner.id,
                                      name: partner.name,
                                      profileImg: partner.profileImg,
                                      phone: partner.phone,
                                      role: Role.user,
                                    ));
                              }
                            } else if (notification.title == 'new request') {
                              GoRouter.of(context)
                                  .push(MyProductsViews.routeName);
                            }
                          },
                          onDelete: () => notificationCubit
                              .deleteNotification(notification.id),
                        );
                      },
                    );
                  } else if (state is NotificationError) {
                    return Center(
                      child: Text(
                        context.tr.error + state.message,
                        style: AppTextStyles.medium16()
                            .copyWith(color: ColorsBox.red),
                      ),
                    );
                  } else {
                    return Center(child: Text(context.tr.no_notifications));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
