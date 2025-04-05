import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
part 'widget/page_indicator.dart';
part 'widget/on_boarding_text.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  static const routeName = '/onBoard_route';

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> onboardingData = [
      {
        'title': "${context.tr.onBoardingTitle} ${context.tr.appName}",
        'subtitle': context.tr.onBoardingSubtitle2,
        'description': context.tr.onBoardingDescription1
      },
      {
        'title': "${context.tr.onBoardingTitle} ${context.tr.appName}",
        'subtitle': context.tr.onBoardingSubtitle2,
        'description': context.tr.onBoardingDescription2
      },
      {
        'title': "${context.tr.onBoardingTitle} ${context.tr.appName}",
        'subtitle': context.tr.onBoardingSubtitle3,
        'description': context.tr.onBoardingDescription3
      },
    ];

    return Scaffold(
      backgroundColor: ColorsBox.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at top right
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => GoRouter.of(context)
                    .push(LoginScreen.routeName, extra: LoginViewArgs()),
                child: Text(
                  context.tr.skip,
                  style: AppTextStyles.medium16().copyWith(
                    color: ColorsBox.brightBlue,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              AppImageAssets.onboardingImage,
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: MediaQuery.sizeOf(context).width * 0.7,
              fit: BoxFit.contain,
            ),

            // Page view for onboarding screens
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (_, index) {
                  return _OnBoardingText(
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                    description: onboardingData[index]['description']!,
                  );
                },
              ),
            ),

            // Page indicator
            _PageIndicator(currentPage: _currentPage),

            // Next button
            Padding(
              padding: const EdgeInsets.all(24),
              child: FloatingActionButton(
                onPressed: () {
                  if (_currentPage < onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else {
                    GoRouter.of(context)
                        .push(LoginScreen.routeName, extra: LoginViewArgs());
                  }
                },
                backgroundColor: ColorsBox.brightBlue,
                elevation: 0,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
