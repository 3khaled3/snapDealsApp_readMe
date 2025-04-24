import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';

class ChatViewArgs {}

class ChatView extends StatelessWidget {
  const ChatView({this.args, super.key});
  final ChatViewArgs? args;
  static const String routeName = '/chat_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocListener<ProfileCubit, ProfileStates>(
                bloc: ProfileCubit.instance,
                listener: (context, state) {
                  if (state is ProfileInitial) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.showSuccessSnackBar(
                        message: context.tr.logout_success,
                      );
                      GoRouter.of(context).pushReplacement(
                          LoginScreen.routeName,
                          extra: LoginViewArgs());
                    });
                  } else if (state is ProfileError) {
                    context.showErrorSnackBar(
                      message: context.tr.logout_error,
                    );
                    Navigator.of(context).pop();
                  } else if (state is ProfileLoading) {
                    context.showLoadingDialog();
                  }
                },
                child: CustomPrimaryButton(
                  title: context.tr.loginButton,
                  onTap: () async {
                    await ProfileCubit.instance.logoutUser();
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (context.tr.lang == "ar") {
                          BlocProvider.of<LangCubit>(context)
                              .changeLang(Langs.en);
                        } else {
                          BlocProvider.of<LangCubit>(context)
                              .changeLang(Langs.ar);
                        }
                      },
                      icon: const Icon(Icons.language)),
                  Text(
                    context.tr.loginScreenLabel,
                    style: AppTextStyles.bold12(),
                  ),
                  IconButton(
                    onPressed: () {
                      // GoRouter.of(context).push(
                      //   OnBoardScreen.routeName,
                      // );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
