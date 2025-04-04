import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_contanier.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_drop_down_button.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AddDetailsArgs {
  final String title;
  IconData? icon;

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
              Text(
                context.tr.category,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              7.ph,
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration:
                        const BoxDecoration(color: ColorsBox.brightBlue),
                    child: Icon(
                      widget.args!.icon,
                      color: ColorsBox.white,
                      size: 30,
                    ),
                  ),
                  10.pw,
                  Text(
                    widget.args!.title,
                    style: AppTextStyles.semiBold12()
                        .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                  ),
                ],
              ),
              23.ph,
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Icon(
                            Icons.home,
                            color: ColorsBox.brightBlue,
                            size: 26,
                          ),
                        ),
                        6.pw,
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Icon(
                            Icons.pedal_bike,
                            color: ColorsBox.brightBlue,
                            size: 26,
                          ),
                        ),
                        6.pw,
                        Container(
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Icon(
                            Icons.home,
                            color: ColorsBox.brightBlue,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                    15.ph,
                    InkWell(
                      onTap: () {},
                      child: CustomContainer(
                        width: 120,
                        height: 50,
                        text: context.tr.addImages,
                        textStyle: AppTextStyles.medium14()
                            .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                        borderColor: ColorsBox.brightBlue,
                        borderRadius: 5.0,
                        onTap: () {},
                      ),
                    ),
                    16.ph,
                    Text(
                      context.tr.addImageDis,
                      style: AppTextStyles.regular12()
                          .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              23.ph,
              Text(
                context.tr.brand,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              6.ph,
              CustomTextFormField(hintText: context.tr.brandHint),
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
              Text(
                context.tr.adTitle,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              6.ph,
              CustomTextFormField(hintText: context.tr.enterTitle),
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
