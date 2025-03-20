import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';

class YourProfileView extends StatefulWidget {
  const YourProfileView({super.key});

  static const String routeName = '/your_profile_route';

  @override
  State<YourProfileView> createState() => _YourProfileViewState();
}

class _YourProfileViewState extends State<YourProfileView> {
  String gender = 'male';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 70,
          left: 34,
          right: 21,
          bottom: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            12.ph,
            _buildProfileSection(),
            49.ph,
            _buildFormFields(context),
            37.ph,
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Divider(thickness: 1, color: Colors.grey),
            ),
            24.ph,
            _buildContactSection(context),
            57.ph,
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60),
      child: Text(
        context.tr.yourProfileLabel,
        style: AppTextStyles.semiBold20().copyWith(
          fontFamily: AppTextStyles.fontFamilyLora,
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(AppImageAssets.profileImage),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: ColorsBox.brightBlue,
                  child: Icon(EvaIcons.cameraOutline,
                      size: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        27.pw,
        Expanded(
          child: CustomTextFormField(
            hintText: context.tr.yourName,
            labelText: context.tr.Name,
            validator: Validators.validateEmail,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: context.tr.yourAge,
          labelText: context.tr.Age,
          validator: Validators.validateAge,
          keyboardType: TextInputType.number,
        ),
        24.ph,
        _buildGenderDropdown(context),
        24.ph,
        CustomTextFormField(
          hintText: context.tr.yourAddress,
          labelText: context.tr.Address,
          validator: Validators.validateAddress,
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsBox.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: DropdownButton<String>(
          items: [
            DropdownMenuItem(value: 'male', child: Text(context.tr.male)),
            DropdownMenuItem(value: 'female', child: Text(context.tr.female)),
          ],
          value: gender,
          underline: const SizedBox(),
          isExpanded: true,
          style: AppTextStyles.regular16().copyWith(color: ColorsBox.slateGrey),
          onChanged: (String? value) => setState(() => gender = value!),
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.contactInformation,
          style: AppTextStyles.semiBold20().copyWith(
            fontFamily: AppTextStyles.fontFamilyLora,
          ),
        ),
        24.ph,
        CustomTextFormField(
          hintText: context.tr.yourNumber,
          labelText: context.tr.Number,
          validator: Validators.validateNumber,
          keyboardType: TextInputType.number,
        ),
        8.ph,
        Text(context.tr.contactNumber, style: AppTextStyles.regular12()),
        18.ph,
        CustomTextFormField(
          hintText: context.tr.hintEmail,
          labelText: context.tr.emailLabel,
          validator: Validators.validateEmail,
        ),
        8.ph,
        Text(context.tr.contactEmail, style: AppTextStyles.regular12()),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => GoRouter.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            fixedSize: const Size(55, 55),
          ),
          child: const Icon(Icons.arrow_back_ios, color: ColorsBox.brightBlue),
        ),
        30.pw,
        Expanded(
          child: CustomPrimaryButton(
            title: context.tr.saveButton,
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                // Handle save action
              }
            },
          ),
        ),
      ],
    );
  }
}
