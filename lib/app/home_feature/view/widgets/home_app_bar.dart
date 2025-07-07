import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/notification/view/notification_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(this.name, {super.key});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// User Image
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(99999),
            splashColor: ColorsBox.brightBlue.withOpacity(0.2),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorsBox.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99999),
                child: CachedNetworkImage(
                  imageUrl: ProfileCubit.instance.state.profile.profileImg ?? "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                  placeholder: (context, url) => SvgPicture.asset(
                    AppImageAssets.defaultProfile,
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    AppImageAssets.defaultProfile,
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                  height: 48,
                  width: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          16.pw,

          /// User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.homeTitle,
                style: AppTextStyles.regular16().copyWith(
                  color: ColorsBox.blueGrey,
                ),
              ),
              2.ph,
              Text(
                ProfileCubit.instance.state.profile.role == Role.unregistered
                    ? context.tr.welcome
                    : name,
                style: AppTextStyles.semiBold20(),
              ),
            ],
          ),

          const Spacer(),

          /// Notification Icon
          InkWell(
            onTap: () {
              if (ProfileCubit.instance.state.profile.role ==
                  Role.unregistered) {
                GoRouter.of(context)
                    .push(LoginScreen.routeName, extra: LoginViewArgs());
                return;
              }
              GoRouter.of(context).push(NotificationsView.route);
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: ColorsBox.brightBlue.withOpacity(0.1),
            child: Ink(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: ColorsBox.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: ColorsBox.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: ColorsBox.brightBlue,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
