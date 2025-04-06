import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/settings.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/your_profile.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_bottom_sheet.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            80.ph,
            const SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  AppImageAssets.profileImage,
                ),
              ),
            ),
            12.ph,
            Text(
              "Ziad Tamer",
              style: AppTextStyles.semiBold24()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            ),
            27.ph,
            Column(
              children: [
                CustomListTile(
                  isAddView: false,
                  leadingIcon: Icons.person_2_outlined,
                  title: 'Your Profile',
                  onTap: () {
                    GoRouter.of(context).push(YourProfileView.routeName);
                  },
                ),
                spaceBetweenListTile(),
                CustomListTile(
                  isAddView: false,
                  leadingIcon: Icons.subdirectory_arrow_right_outlined,
                  title: 'About us',
                  onTap: () {
                    GoRouter.of(context).push(AboutUsView.routeName);
                  },
                ),
                spaceBetweenListTile(),
                CustomListTile(
                  isAddView: false,
                  leadingIcon: Icons.password_outlined,
                  title: 'Password  Manager',
                  onTap: () {
                    CustomBottomSheet.showPasswordManagerSheet(context);
                  },
                ),
                spaceBetweenListTile(),
                CustomListTile(
                  isAddView: false,
                  leadingIcon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    GoRouter.of(context).push(SettingsView.routeName);
                  },
                ),
                spaceBetweenListTile(),
                CustomListTile(
                  isAddView: false,
                  leadingIcon: Icons.logout_outlined,
                  title: 'Log out',
                  onTap: () {
                    CustomBottomSheet.showLogoutSheet(context);
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey.shade300,
                ),
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
