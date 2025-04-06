import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_details_title.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_image.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_contanier.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_drop_down_button.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AddDetailsArgs {
  final String title;
  final IconData? icon;

  AddDetailsArgs({required this.title, this.icon});
}

class AddDetailsView extends StatefulWidget {
  const AddDetailsView({
    super.key,
    this.args,
  });
  static const String routeName = '/add_route';
  final AddDetailsArgs? args;

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderAddView(
                  title: context.tr.adDetails, icon: Icons.arrow_back_ios_new),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              15.ph,
              CustomAddDetailsTitle(
                title: widget.args!.title,
                icon: widget.args!.icon,
              ),
              23.ph,
              const CustomAddImage(),
              23.ph,
              CustomAddTextField(
                title: context.tr.brand,
                hint: context.tr.brandHint,
              ),
              widget.args!.title == context.tr.mobilesAndTablets
                  ? _AddMobileDetails(context)
                  : 0.ph,
              23.ph,
              Text(
                context.tr.condition,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              6.ph,
              Row(
                children: [
                  CustomContainer(
                    width: 55,
                    height: 30,
                    backgroundColor: ColorsBox.white,
                    text: context.tr.newWord,
                    textStyle: AppTextStyles.regular12(),
                    borderColor: Colors.black,
                    borderRadius: 10.0,
                    onTap: () {
                      // TODO change background color
                    },
                  ),
                  12.pw,
                  CustomContainer(
                    width: 55,
                    height: 30,
                    backgroundColor: ColorsBox.white,
                    text: context.tr.used,
                    textStyle: AppTextStyles.regular12()
                        .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                    borderColor: Colors.black,
                    borderRadius: 10.0,
                    onTap: () {
                      // TODO change background color
                    },
                  ),
                ],
              ),
              23.ph,
              CustomAddTextField(
                title: context.tr.adTitle,
                hint: context.tr.enterTitle,
              ),
              23.ph,
              Text(
                context.tr.describtion,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              6.ph,
              CustomTextFormField(
                hintText: context.tr.describtionHint,
                height: const EdgeInsets.only(
                  bottom: 100,
                  left: 10,
                  right: 10,
                ),
              ),
              23.ph,
              CustomAddTextField(
                title: context.tr.location,
                hint: context.tr.locationHint,
              ),
              23.ph,
              CustomAddTextField(
                title: context.tr.price,
                hint: context.tr.priceHint,
                isPrice: true,
              ),
              7.ph,
              CustomPrimaryButton(title: context.tr.nextButton, onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}

_AddMobileDetails(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      23.ph,
      Text(
        context.tr.ramWord,
        style: AppTextStyles.semiBold12()
            .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
      ),
      6.ph,
      const CustomDropDownButton(index: 1),
      23.ph,
      Text(
        context.tr.storageWord,
        style: AppTextStyles.semiBold12()
            .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
      ),
      6.ph,
      const CustomDropDownButton(index: 2),
      23.ph,
      Text(
        context.tr.batteryCapacityWord,
        style: AppTextStyles.semiBold12()
            .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
      ),
      6.ph,
      const CustomDropDownButton(index: 3),
    ],
  );
}
