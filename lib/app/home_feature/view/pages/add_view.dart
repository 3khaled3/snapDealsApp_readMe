import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_details.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});
  static const String routeName = '/add_details_route';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
        child: Column(
          children: [
            CustomHeaderAddView(title: context.tr.addTitle, icon: Icons.close),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            CustomListTile(
              title: context.tr.electronics,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                        title: context.tr.electronics, icon: Icons.computer));
              },
              leadingIcon: Icons.computer,
              isAddView: true,
            ),
            15.ph,
            CustomListTile(
              title: context.tr.mobilesAndTablets,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      title: context.tr.mobilesAndTablets,
                      icon: Icons.phone_android,
                    ));
              },
              leadingIcon: Icons.phone_android,
              isAddView: true,
            ),
            15.ph,
            CustomListTile(
              title: context.tr.medicalTools,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      title: context.tr.medicalTools,
                      icon: Icons.school_outlined,
                    ));
              },
              isAddView: true,
              leadingIcon: Icons.school_outlined,
            ),
            15.ph,
            CustomListTile(
              title: context.tr.drawingTools,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      icon: Icons.school_outlined,
                      title: context.tr.drawingTools,
                    ));
              },
              isAddView: true,
              leadingIcon: Icons.school_outlined,
            ),
            15.ph,
            CustomListTile(
              title: context.tr.engineeringTools,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      icon: Icons.school_outlined,
                      title: context.tr.engineeringTools,
                    ));
              },
              isAddView: true,
              leadingIcon: Icons.school_outlined,
            ),
            15.ph,
            CustomListTile(
              title: context.tr.courses,
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      icon: Icons.school_outlined,
                      title: context.tr.courses,
                    ));
              },
              isAddView: true,
              leadingIcon: Icons.school_outlined,
            ),
            15.ph,
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(color: ColorsBox.brightBlue),
              ),
              title: Text(
                context.tr.other,
                style: AppTextStyles.regular18()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: ColorsBox.brightBlue,
                size: 25,
              ),
              onTap: () {
                GoRouter.of(context).push(AddDetailsView.routeName,
                    extra: AddDetailsArgs(
                      icon: Icons.school_outlined,
                      title: context.tr.other,
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
