import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
import 'package:snap_deals/app/request_feature/view/pages/my_request_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

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
      // backgroundColor: ColorsBox.paleGrey,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     context.tr.yourProfile,
      //     style: AppTextStyles.semiBold20().copyWith(
      //       fontFamily: AppTextStyles.fontFamilyLora,
      //       color: ColorsBox.black,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CachedNetworkImage(
                imageUrl: ProfileCubit.instance.state.profile.profileImg ?? "",
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
                fontFamily: AppTextStyles.fontFamilyLora,
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
                  onTap: () => GoRouter.of(context).push(AboutUsView.routeName),
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
                  leadingIcon: Icons.password_outlined,
                  title: context.tr.passwordManager,
                  onTap: () =>
                      CustomBottomSheet.showPasswordManagerSheet(context),
                ),
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
                12.ph,
                ProfileCubit.instance.state.profile.role == Role.admin
                    ? CustomListTile(
                        leadingIcon: Icons.person_search_rounded,
                        title: context.tr.accessUsers,
                        onTap: () =>
                            GoRouter.of(context).push(AccessUsers.routeName),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
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
