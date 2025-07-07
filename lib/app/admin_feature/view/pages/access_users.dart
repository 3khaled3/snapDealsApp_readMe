import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/access_user_body.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AccessUsers extends StatelessWidget {
  const AccessUsers({super.key});

  static const String routeName = '/access-users';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccessUserCubit(),
      child: Scaffold(
        body: Column(
          children: [
            MediaQuery.of(context).padding.top.ph,
            CustomAppBar(title: context.tr.accessUsers),
            const Expanded(child: AccessUsersBody()),
          ],
        ),
      ),
    );
  }
}
