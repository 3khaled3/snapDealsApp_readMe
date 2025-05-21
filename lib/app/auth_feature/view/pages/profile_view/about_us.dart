import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const String routeName = '/about_us_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.aboutUs),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Title Section with app name
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
                              fontFamily: context.tr.fontFamilyLora,
                            ),
                          ),
                        ],
                      ),

                      20.ph,

                      /// App Icon SVG
                      SvgPicture.asset(
                        AppImageAssets.appIcon,
                        width: 120,
                        height: 120,
                      ),

                      40.ph, // Space between icon and content

                      /// Content Sections
                      _buildContentSection(
                        context: context,
                        title: context.tr.onBoardingSubtitle1,
                        description: context.tr.onBoardingDescription1,
                      ),
                      40.ph,
                      _buildContentSection(
                        context: context,
                        title: context.tr.onBoardingSubtitle2,
                        description: context.tr.onBoardingDescription2,
                      ),
                      40.ph,
                      _buildContentSection(
                        context: context,
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
      ),
    );
  }

  // Helper function to create a reusable content section with title and description
  Widget _buildContentSection({
    required String title,
    required String description,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold20().copyWith(
            fontFamily: context.tr.fontFamilyLora,
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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
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
