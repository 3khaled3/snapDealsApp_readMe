//handle go router
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_course_details.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_details.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/courses.dart';
import 'package:snap_deals/app/home_feature/view/pages/favorite_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/pages/products.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/create_course_cubit/create_course_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/create_product_cubit/create_product_cubit.dart';

abstract class HomeRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: HomeView.routeName,
      builder: (context, state) {
        HomeViewArgs? args;
        if (state.extra != null) {
          args = state.extra as HomeViewArgs;
        }

        return HomeView(args: args);
      },
    ),
    GoRoute(
      path: MainHomeView.routeName,
      builder: (context, state) {
        MainHomeViewArgs? args;
        if (state.extra != null) {
          args = state.extra as MainHomeViewArgs;
        }

        return MainHomeView(args);
      },
    ),
    GoRoute(
      path: FavoriteView.routeName,
      builder: (context, state) {
        FavoriteViewArgs? args;
        if (state.extra != null) {
          args = state.extra as FavoriteViewArgs;
        }

        return FavoriteView(args: args);
      },
    ),

    GoRoute(
      path: ProductsView.routeName,
      builder: (context, state) {
        ProductsViewArgs? args;
        if (state.extra != null) {
          args = state.extra as ProductsViewArgs;
        }

        return ProductsView(args: args);
      },
    ),

    GoRoute(
      path: CoursesView.routeName,
      builder: (context, state) {
        CoursesViewArgs? args;
        if (state.extra != null) {
          args = state.extra as CoursesViewArgs;
        }

        return CoursesView(args: args);
      },
    ),

    GoRoute(
      path: AddView.routeName,
     builder: (context, state) {
       

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EditCategoryCubit()),
          ],
          child: AddView(),
        );
      },
    ),

    GoRoute(
      path: AddDetailsView.routeName,
      builder: (context, state) {
        AddDetailsArgs? args;
        if (state.extra != null) {
          args = state.extra as AddDetailsArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CreateProductCubit()),
          ],
          child: AddDetailsView(args: args,),
        );
      },
    ),

    GoRoute(
      path: AddCourseDetails.routeName,
      builder: (context, state) {
        AddCourseDetailsArgs? args;
        if (state.extra != null) {
          args = state.extra as AddCourseDetailsArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CreateCourseCubit()),
          ],
          child: AddCourseDetails(args: args,),
        );
      },
    ),


    //add any other routes in same feature
  ];
}
