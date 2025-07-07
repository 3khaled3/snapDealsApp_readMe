import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/search_feature/view/search_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CategoryAppBar extends StatelessWidget {
  const CategoryAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
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
                title,
                style: AppTextStyles.semiBold20().copyWith(
                  fontFamily: context.tr.fontFamilyLora,
                ),
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push(SearchView.route);
                },
                icon: const Icon(Icons.search)),
            16.pw,
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
}
