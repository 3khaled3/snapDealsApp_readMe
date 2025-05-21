import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/privacy_Policy.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  static const String routeName = '/settings_route';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  bool _languageExpanded = false;

  late final AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  void _toggleLanguageExpand() {
    setState(() {
      _languageExpanded = !_languageExpanded;
      if (_languageExpanded) {
        _arrowAnimationController.forward();
      } else {
        _arrowAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar with subtle shadow
            CustomAppBar(
              title:
                  _languageExpanded ? context.tr.Language : context.tr.Settings,
            ),
            8.ph,

            Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: 5,
                separatorBuilder: (_, __) => Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      // Language header tile with rotating arrow
                      return ListTile(
                        title: Text(
                          context.tr.Language,
                          style: AppTextStyles.semiBold18(),
                        ),
                        trailing: RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5)
                              .animate(_arrowAnimationController),
                          child: Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: ColorsBox.brightBlue,
                            size: 28,
                          ),
                        ),
                        onTap: _toggleLanguageExpand,
                      );

                    case 1:
                      return AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              _languageOption(
                                context,
                                label: context.tr.Arabic,
                                fontFamily:
                                    AppTextStyles.fontFamilyNotoKufiArabic,
                                isSelected: context.tr.lang == "ar",
                                onTap: () {
                                  BlocProvider.of<LangCubit>(context)
                                      .changeLang(Langs.ar);
                                },
                              ),
                              const SizedBox(height: 10),
                              _languageOption(
                                context,
                                label: context.tr.English,
                                isSelected: context.tr.lang == "en",
                                onTap: () {
                                  BlocProvider.of<LangCubit>(context)
                                      .changeLang(Langs.en);
                                },
                              ),
                            ],
                          ),
                        ),
                        crossFadeState: _languageExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 250),
                      );

                    case 2:
                      // Privacy Policy
                      return CustomListTile(
                        title: context.tr.privacyPolicy,
                        onTap: () {
                          GoRouter.of(context)
                              .push(PrivacyPolicyView.routeName);
                        },
                      );

                    case 3:
                      // About Us
                      return CustomListTile(
                        title: context.tr.aboutUs,
                        onTap: () {
                          GoRouter.of(context).push(AboutUsView.routeName);
                        },
                      );

                    case 4:
                      // App Version
                      return ListTile(
                        title: Text(
                          context.tr.Version,
                          style: AppTextStyles.regular18(),
                        ),
                        trailing: Text(
                          "1.0.0",
                          style: AppTextStyles.regular16(),
                        ),
                      );

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageOption(BuildContext context,
      {required String label,
      required bool isSelected,
      required VoidCallback onTap,
      String? fontFamily}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.regular18().copyWith(
                  fontFamily: fontFamily,
                  color: isSelected ? ColorsBox.brightBlue : ColorsBox.blueGrey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: ColorsBox.brightBlue,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
