import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';

import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  static const String routeName = '/privacy_policy_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.privacyPolicy),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.ph,
                      Text(context.tr.CancelationPolicy,
                          style: AppTextStyles.medium20().copyWith(
                              fontFamily: AppTextStyles.fontFamilyLora,
                              color: ColorsBox.brightBlue)),
                      15.ph,
                      Text(
                        context.tr.CancelationPolicyDiscription1,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.CancelationPolicyDiscription2,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.CancelationPolicyDiscription3,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.CancelationPolicyDiscription4,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.CancelationPolicyDiscription5,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.CancelationPolicyDiscription6,
                        style: AppTextStyles.medium16(),
                      ),
                      39.ph,
                      Text(context.tr.TermsAndCondition,
                          style: AppTextStyles.medium20().copyWith(
                              fontFamily: AppTextStyles.fontFamilyLora,
                              color: ColorsBox.brightBlue)),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle1,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription1,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle2,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription2,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle3,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription3,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle4,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription4,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle5,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription5,
                        style: AppTextStyles.medium16(),
                      ),
                      15.ph,
                      Text(
                        context.tr.TermsAndConditionTitle6,
                        style: AppTextStyles.medium16(),
                      ),
                      Text(
                        context.tr.TermsAndConditionDiscription6,
                        style: AppTextStyles.medium16(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
