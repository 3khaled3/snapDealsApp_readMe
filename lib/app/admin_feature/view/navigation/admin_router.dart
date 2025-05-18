import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/pages/access_users.dart';
import 'package:snap_deals/app/admin_feature/view/pages/edit_category.dart';

abstract class AdminRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: EditCategory.routeName,
      builder: (context, state) {
        EditCategoryArgs? args;
        if (state.extra != null) {
          args = state.extra as EditCategoryArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EditCategoryCubit()),
          ],
          child: EditCategory(args: args),
        );
      },
    ),

    GoRoute(
      path: AccessUsers.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EditCategoryCubit()),
          ],
          child: const AccessUsers(),
        );
      },
    ),
    //add any other routes in same feature
  ];
}
