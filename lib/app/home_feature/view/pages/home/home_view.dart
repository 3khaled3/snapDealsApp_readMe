import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';

class HomeViewArgs {
  //todo add any parameters you need
}

class HomeView extends StatelessWidget {
  const HomeView(this.args, {super.key});
  final HomeViewArgs? args;
  static const String routeName = '/home_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (Tr.current.lang == "ar") {
                      BlocProvider.of<LangCubit>(context)
                          .changeLang(AvailableLang.en);
                    } else {
                      BlocProvider.of<LangCubit>(context)
                          .changeLang(AvailableLang.ar);
                    }
                  },
                  icon: const Icon(Icons.language)),
              Text(
                context.tr.hello,
                style: AppTextStyles.medium12(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
