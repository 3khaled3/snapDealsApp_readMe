import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
     final String userId=uesrs.id;
  final String userName =uesrs.name;
  final String userEmail=uesrs.email;
  final String userPhoneNumber =uesrs.phone ?? "No Phone Number";
  final String useerimage = uesrs.profileImg ?? "";
    return Card(
      color: ColorsBox.white,
       elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Padding(padding: const EdgeInsets.all(12),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              
              children: [
                Text('ID: $userId', style: AppTextStyles.bold12(), maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                8.pw,
               CustomCopyButton(
                          textToCopy: userId,
                        ),
                const Spacer(),
                 IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                CustomDialog.deleteUser(context, userId);
              }
            ),
              ],
            ),
            8.ph,
            Row(
              children: [
              CircleAvatar(
  radius: 37,
  backgroundImage: buildUserImage(useerimage),
),


                20.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(userName, style: AppTextStyles.bold16(), maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                        8.pw,
                        CustomCopyButton(
                          textToCopy: userName,
                        ),
                      ],
                    ),
                    7.ph,
                    Row(
                      children: [
                        SizedBox(
                          width: 190,
                          child: Text(userEmail, style: AppTextStyles.semiBold14(), maxLines: 1,
                                                overflow: TextOverflow.ellipsis,),
                        ),
                        8.pw,
                        CustomCopyButton(
                          textToCopy: userEmail,
                        ),
                      ],
                    ),
                    7.ph,
                    Row(
                      children: [
                        Text(userPhoneNumber, style: AppTextStyles.semiBold14(), maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                        8.pw,
                        CustomCopyButton(
                          textToCopy: userPhoneNumber,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
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

