import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/request_feature/model_view/cancel_request_cubit/cancel_request_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/get_my_request_cubit/get_my_request_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/get_my_request_cubit/get_my_request_state.dart';
import 'package:snap_deals/app/request_feature/view/widget/request_card.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class MyRequestViewArgs {}

class MyRequestView extends StatelessWidget {
  const MyRequestView({
    super.key,
  });
  static const String routeName = '/my_request_view';
  // final MyRequestViewArgs? args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetMyRequestsCubit()..getMyRequests()),
        BlocProvider(
            create: (_) => CancelRequestCubit()), // ✅ تأكد إنه متوفر هنا
      ],
      child: BlocListener<CancelRequestCubit, CancelRequestState>(
        listenWhen: (previous, current) =>
            current is CancelRequestSuccess, // بس لما يحصل إلغاء
        listener: (context, state) {
          if (state is CancelRequestSuccess) {
            // ✅ حدث الطلبات بعد الإلغاء
            context.read<GetMyRequestsCubit>().getMyRequests();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: context.tr.my_requests),
                Expanded(
                  child: BlocBuilder<GetMyRequestsCubit, GetMyRequestsState>(
                    builder: (context, state) {
                      if (state is GetMyRequestsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetMyRequestsSuccess) {
                        final requests = state.requests;
                        return ListView.builder(
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RequestCard(request: request),
                                20.ph,
                              ],
                            );
                          },
                        );
                      } else if (state is GetMyRequestsError) {
                        return const Center(
                            child: Text("حدث خطأ أثناء تحميل البيانات."));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
