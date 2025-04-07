import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

class _SettingsViewState extends State<SettingsView> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
        child: Column(
          children: [
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    fixedSize: const Size(55, 55),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsBox.brightBlue,
                      size: 27,
                    ),
                  ),
                ),
                60.pw,
                Text(
                  isClicked ? context.tr.Language : context.tr.Settings,
                  style: AppTextStyles.semiBold24()
                      .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                )
              ],
            ),
            26.ph,
            ListTile(
              title: Text(
                context.tr.Language,
                style: AppTextStyles.regular18(),
              ),
              trailing: isClicked
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorsBox.brightBlue,
                      size: 25,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_right,
                      color: ColorsBox.brightBlue,
                      size: 25,
                    ),
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                });
              },
            ),
            spaceBetweenListTile(),
            isClicked
                ? Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(context.tr.Arabic,
                              style: AppTextStyles.regular18().copyWith(
                                fontFamily:
                                    AppTextStyles.fontFamilyNotoKufiArabic,
                              )),
                          trailing: Icon(
                            Icons.settings_outlined,
                            color: context.tr.lang == "ar"
                                ? ColorsBox.brightBlue
                                : ColorsBox.blueGrey,
                            size: 30,
                          ),
                          onTap: () {
                            BlocProvider.of<LangCubit>(context)
                                .changeLang(Langs.ar);
                          },
                        ),
                        spaceBetweenListTile(),
                        ListTile(
                          title: Text(context.tr.English,
                              style: AppTextStyles.regular18()),
                          trailing: Icon(
                            Icons.settings_outlined,
                            color: context.tr.lang == "en"
                                ? ColorsBox.brightBlue
                                : ColorsBox.blueGrey,
                            size: 30,
                          ),
                          onTap: () {
                            BlocProvider.of<LangCubit>(context)
                                .changeLang(Langs.en);
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            CustomListTile(
              title: context.tr.privacyPolicy,
              onTap: () {
                GoRouter.of(context).push(PrivacyPolicyView.routeName);
              },
            ),
            spaceBetweenListTile(),
            ListTile(
                title:
                    Text(context.tr.Version, style: AppTextStyles.regular18()),
                trailing: Text("1.0.0", style: AppTextStyles.regular18())),
            spaceBetweenListTile(),
          ],
        ),
      ),
    );
  }
}

spaceBetweenListTile() {
  return Container(
    width: double.infinity,
    height: 2,
    color: Colors.grey.shade300,
  );
}
