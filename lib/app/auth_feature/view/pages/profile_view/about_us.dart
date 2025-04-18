import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const String routeName = '/about_us_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          12.ph,
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: CustomBackButton(),
              ),
              16.pw,
              Center(
                child: Text(
                  context.tr.aboutUs,
                  style: AppTextStyles.semiBold20().copyWith(
                    fontFamily: AppTextStyles.fontFamilyLora,
                  ),
                ),
              ),
              SizedBox()
            ],
          ),
          12.ph,
          Divider(
            color: ColorsBox.greyishTwo,
            height: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Title Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.tr.onBoardingTitle,
                          style: AppTextStyles.bold24().copyWith(
                            color: ColorsBox.black,
                          ),
                        ),
                        Text(
                          context.tr.appName,
                          style: AppTextStyles.bold24().copyWith(
                            color: ColorsBox.brightBlue,
                            fontFamily: AppTextStyles.fontFamilyLora,
                          ),
                        ),
                      ],
                    ),

                    40.ph, // Space between title and description

                    /// Content Section
                    _buildContentSection(
                      title: context.tr.onBoardingSubtitle1,
                      description: context.tr.onBoardingDescription1,
                    ),
                    40.ph,
                    _buildContentSection(
                      title: context.tr.onBoardingSubtitle2,
                      description: context.tr.onBoardingDescription2,
                    ),
                    40.ph,
                    _buildContentSection(
                      title: context.tr.onBoardingSubtitle3,
                      description: context.tr.onBoardingDescription3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create a reusable content section with title and description
  Widget _buildContentSection({
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold20().copyWith(
            fontFamily: AppTextStyles.fontFamilyLora,
            color: ColorsBox.black,
          ),
        ),
        10.ph, // Space between title and description
        Text(
          description,
          style: AppTextStyles.medium16().copyWith(
            color: ColorsBox.greyish,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
