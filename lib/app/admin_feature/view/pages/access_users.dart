import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/access_user_body.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AccessUsers extends StatelessWidget {
  const AccessUsers({super.key});

  static const String routeName = '/access-users';

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => AccessUserCubit()..getAllUsersData(page: '1', limit: '5'),
    child: Scaffold(
      backgroundColor: ColorsBox.white,
      appBar: AppBar(
        title: Text(
          context.tr.accessUsers,
          style: AppTextStyles.bold24(),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ColorsBox.white,
      ),
      body: const AccessUsersBody(), // افصل الـbody في ويدجت مستقلة للحفاظ على النقاء
    ),
  );
}

}
