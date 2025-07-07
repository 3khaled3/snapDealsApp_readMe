import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_copy_button.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_dialog.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.uesrs});
  final UserModel uesrs;

  @override
  Widget build(BuildContext context) {
    final String userId = uesrs.id;
    final String userName = uesrs.name;
    final String userEmail = uesrs.email;
    final String userPhoneNumber = uesrs.phone ?? "No Phone Number";
    final String userImage = uesrs.profileImg ?? "";

    return Card(
      color: ColorsBox.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.grey, width: 0.4),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row (ID + Copy + Delete)
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ID: $userId',
                    style: AppTextStyles.bold12(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomCopyButton(textToCopy: userId),
                6.pw,
                IconButton(
                  onPressed: () => CustomDialog.deleteUser(context, userId),
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  tooltip: 'Delete User',
                ),
              ],
            ),
            12.ph,

            /// Profile + Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                CircleAvatar(
                  radius: 35,
                  backgroundColor:  Colors.grey.shade200,
                  backgroundImage: buildUserImage(userImage),
                ),
                16.pw,

                /// User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name + Copy
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              userName,
                              style: AppTextStyles.bold16(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CustomCopyButton(textToCopy: userName),
                        ],
                      ),
                      8.ph,

                      /// Email + Copy
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              userEmail,
                              style: AppTextStyles.semiBold14(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CustomCopyButton(textToCopy: userEmail),
                        ],
                      ),
                      8.ph,

                      /// Phone + Copy
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              userPhoneNumber,
                              style: AppTextStyles.semiBold14(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CustomCopyButton(textToCopy: userPhoneNumber),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ImageProvider buildUserImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return const AssetImage(AppImageAssets.profileImage);
  } else if (imageUrl.startsWith('http')) {
    return NetworkImage(imageUrl);
  } else if (imageUrl.startsWith('file://')) {
    final correctedPath = imageUrl.replaceFirst('file://', '');
    return FileImage(File(correctedPath));
  } else {
    return const AssetImage(AppImageAssets.profileImage);
  }
}
