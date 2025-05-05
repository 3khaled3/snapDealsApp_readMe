import 'package:flutter/material.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_search_user.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/user_builder.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AccessUsers extends StatelessWidget {
  const AccessUsers({super.key});

  static const String routeName = '/access-users';

  @override
  Widget build(BuildContext context) {
    final AccessUserCubit accessUserCubit = AccessUserCubit();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.accessUsers,
          style: AppTextStyles.bold24(),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔍 عنصر البحث
            SearchUserByIdWidget(
              onSearch: (userId) async {
                await accessUserCubit.getUserDataById(userId);
              },
              onClearSearch: () {
                accessUserCubit.getAllUsersData(page: '1', limit: '5');
              },
            ),
            const SizedBox(height: 20),

            /// 👤 قائمة المستخدمين
            Expanded(
              child: UserBuilder(accessUserCubit: accessUserCubit),
            ),
          ],
        ),
      ),
    );
  }
}
