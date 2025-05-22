import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/product_feature/model_view/review_cubit/review_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/course_details_view.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/edit_product.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/product_details_view.dart';

abstract class ProductRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: ProductDetailsView.routeName,
      builder: (context, state) {
        ProductDetailsArgs args = state.extra as ProductDetailsArgs;

        return ProductDetailsView(args: args);
      },
    ),

    GoRoute(
      path: CourseDetailsView.routeName,
      builder: (context, state) {
        CourseDetailsViewArgs? args;
        if (state.extra != null) {
          args = state.extra as CourseDetailsViewArgs;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ReviewCubit()),
          ],
          child: CourseDetailsView(args: args),
        );
        
      },
    ),

    GoRoute(
      path: EditDetailsView.routeName,
      builder: (context, state) {
        EditDetailsArgs? args;
        if (state.extra != null) {
          args = state.extra as EditDetailsArgs;
        }

        return EditDetailsView(args: args);
      },
    ),

    //add any other routes in same feature
  ];
}
