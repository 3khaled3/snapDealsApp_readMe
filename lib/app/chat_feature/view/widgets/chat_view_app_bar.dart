import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ChatViewAppBar extends StatelessWidget {
  const ChatViewAppBar({
    super.key,
    required this.partner,
  });

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff0052cc),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ChatBackButton(),
                    10.pw,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl: partner.profileImg ?? "",
                        placeholder: (context, url) => SvgPicture.asset(
                          AppImageAssets.defaultProfile,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          AppImageAssets.defaultProfile,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    10.pw,
                    Text(partner.name,
                        style: AppTextStyles.bold22()
                            .copyWith(color: ColorsBox.white)),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: ColorsBox.greyWithOpacity20),
          ],
        ),
      ),
    );
  }
}

class ChatBackButton extends StatelessWidget {
  const ChatBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => GoRouter.of(context).pop(),
        child: Ink(
          decoration: BoxDecoration(
            color: ColorsBox.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: ColorsBox.greyish, width: 1),
          ),
          padding:
              const EdgeInsetsDirectional.only(start: 8, top: 4, bottom: 4),
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorsBox.brightBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
