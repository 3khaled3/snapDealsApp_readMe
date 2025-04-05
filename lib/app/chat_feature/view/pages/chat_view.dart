import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (context.tr.lang == "ar") {
                      BlocProvider.of<LangCubit>(context).changeLang(Langs.en);
                    } else {
                      BlocProvider.of<LangCubit>(context).changeLang(Langs.ar);
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
                  icon: const Icon(Icons.arrow_back_ios))
            ],
          ),
        ),
      ),
    );
  }
}
