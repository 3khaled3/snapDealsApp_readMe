import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/request_feature/model_view/approve_request_cubit/approve_request_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/get_requests_by_id_cubit/get_requests_by_id_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/get_requests_by_id_cubit/get_requests_by_id_state.dart';
import 'package:snap_deals/app/request_feature/model_view/reject_request_cubit/reject_request_cubit.dart';
import 'package:snap_deals/app/request_feature/view/widget/instractor_request_card.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class InstractorRequestViewArgs {
  final String courseId;
  InstractorRequestViewArgs({required this.courseId});
}

class InstractorRequestView extends StatelessWidget {
  const InstractorRequestView({super.key, this.args});
  final InstractorRequestViewArgs? args;
  static const String routeName = '/instractor_request_view';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                GetRequestsByIdCubit()..getRequestsById(args!.courseId)),
        BlocProvider(create: (_) => ApproveRequestCubit()),
        BlocProvider(create: (_) => RejectRequestCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ApproveRequestCubit, ApproveRequestState>(
            listenWhen: (prev, curr) => curr is ApproveRequestSuccess,
            listener: (context, state) {
              context
                  .read<GetRequestsByIdCubit>()
                  .getRequestsById(args!.courseId);
            },
          ),
          BlocListener<RejectRequestCubit, RejectRequestState>(
            listenWhen: (prev, curr) => curr is RejectRequestSuccess,
            listener: (context, state) {
              context
                  .read<GetRequestsByIdCubit>()
                  .getRequestsById(args!.courseId);
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsBox.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              context.tr.my_requests,
              style: AppTextStyles.bold20().copyWith(color: ColorsBox.black),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<GetRequestsByIdCubit, GetRequestsByIdState>(
            builder: (context, state) {
              if (state is GetRequestsByIdLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetRequestsByIdSuccess) {
                final requests = state.requests;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InstractorRequestCard(
                          instractorRequestModel: request,
                        ),
                        20.ph,
                      ],
                    );
                  },
                );
              } else if (state is GetRequestsByIdError) {
                return const Center(
                    child: Text("حدث خطأ أثناء تحميل البيانات."));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
