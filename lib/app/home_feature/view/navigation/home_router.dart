//handle go router
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/app/home_feature/view_model/product_cubit/product_cubit.dart';

abstract class HomeRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) {
        HomeViewArgs? args;
        if (state.extra != null) {
          args = state.extra as HomeViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: HomeView(args),
        );
      },
    ),
    //add any other routes in same feature
  ];
}
