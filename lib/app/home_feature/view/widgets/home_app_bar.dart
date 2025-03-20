import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
    this.name, {
    super.key,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        28.pw,

        /// <---- user image ---->///
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(99999),
          child: const SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                AppImageAssets.profileImage,
              ),
            ),
          ),
        ),

        10.pw,

        ///<----- user name ----->///
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.homeTitle,
              style:
                  AppTextStyles.regular16().copyWith(color: ColorsBox.blueGrey),
            ),
            Text(
              name,
              style: AppTextStyles.semiBold20(),
            ),
          ],
        ),
        const Spacer(),

        /// <---- notification button ---->///
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(200),
          child: Ink(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorsBox.white,
              borderRadius: BorderRadius.circular(200),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: ColorsBox.brightBlue,
            ),
          ),
        ),
        40.pw,
      ],
    );
  }
}
