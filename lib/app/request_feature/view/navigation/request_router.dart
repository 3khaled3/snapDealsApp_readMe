import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/request_feature/view/pages/instractor_request_view.dart';
import 'package:snap_deals/app/request_feature/view/pages/my_request_view.dart';

abstract class RequestRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: MyRequestView.routeName,
      builder: (context, state) {
        // MyRequestViewArgs args = state.extra as MyRequestViewArgs;

        return const MyRequestView();
      },
    ),

    GoRoute(
      path: InstractorRequestView.routeName,
      builder: (context, state) {
        InstractorRequestViewArgs args =
            state.extra as InstractorRequestViewArgs;

        return InstractorRequestView(args: args);
      },
    ),
    //add any other routes in same feature
  ];
}
