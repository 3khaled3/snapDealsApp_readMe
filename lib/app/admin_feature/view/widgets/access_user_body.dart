import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_search_user.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/user_builder.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AccessUsersBody extends StatelessWidget {
  const AccessUsersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final accessUserCubit = context.read<AccessUserCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchUserByIdWidget(
            onSearch: (userId) async {
              await accessUserCubit.getUserDataById(userId);
            },
            onClearSearch: () {
              accessUserCubit.getAllUsersData(page: '1', limit: '5');
            },
          ),
          20.ph,
          Expanded(
            child: UserBuilder(accessUserCubit: accessUserCubit),
          ),
        ],
      ),
    );
  }
}
