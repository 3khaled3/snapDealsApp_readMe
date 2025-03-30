//handle go router
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/courses.dart';
import 'package:snap_deals/app/home_feature/view/pages/favorite_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/pages/products.dart';
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
          child: HomeView(args: args),
        );
      },
    ),
    GoRoute(
      path: MainHomeView.routeName,
      builder: (context, state) {
        MainHomeViewArgs? args;
        if (state.extra != null) {
          args = state.extra as MainHomeViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: MainHomeView(args),
        );
      },
    ),
    GoRoute(
      path: FavoriteView.routeName,
      builder: (context, state) {
        FavoriteViewArgs? args;
        if (state.extra != null) {
          args = state.extra as FavoriteViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: FavoriteView(args: args),
        );
      },
    ),

    GoRoute(
      path: ProductsView.routeName,
      builder: (context, state) {
        ProductsViewArgs? args;
        if (state.extra != null) {
          args = state.extra as ProductsViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: ProductsView(args: args),
        );
      },
    ),

    GoRoute(
      path: CoursesView.routeName,
      builder: (context, state) {
        CoursesViewArgs? args;
        if (state.extra != null) {
          args = state.extra as CoursesViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: CoursesView(args: args),
        );
      },
    ),

    GoRoute(
      path: AddView.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: const AddView(),
        );
      },
    ),

    //add any other routes in same feature
  ];
}
