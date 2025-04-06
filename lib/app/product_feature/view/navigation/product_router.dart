//handle go router
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/home_feature/view_model/product_cubit/product_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/product_details_view.dart';

abstract class ProductRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: ProductDetailsView.routeName,
      builder: (context, state) {
        ProductDetailsArgs? args;
        if (state.extra != null) {
          args = state.extra as ProductDetailsArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: ProductDetailsView(args: args),
        );
      },
    ),

    //add any other routes in same feature
  ];
}
