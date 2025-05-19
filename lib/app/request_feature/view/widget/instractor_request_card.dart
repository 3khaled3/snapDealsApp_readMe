import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/request_feature/data/model/instractor/instractor.request.model.dart';
import 'package:snap_deals/app/request_feature/model_view/approve_request_cubit/approve_request_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/reject_request_cubit/reject_request_cubit.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class InstractorRequestCard extends StatelessWidget {
  const InstractorRequestCard({super.key, required this.instractorRequestModel});
  final InstractorRequestModel instractorRequestModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsBox.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sender: ${instractorRequestModel.sender?.name ?? "Unknown"}',
                  style: AppTextStyles.bold16(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                8.ph,
                Text(
                  'Created At: ${instractorRequestModel.createdAt}',
                  style: AppTextStyles.medium12(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            
            // زر الرفض
            BlocBuilder<RejectRequestCubit, RejectRequestState>(
              builder: (context, state) {
                final isLoading = state is RejectRequestLoading;
                return IconButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final cubit = context.read<RejectRequestCubit>();
                          await cubit.rejectRequest(instractorRequestModel.id!);
                          if (context.mounted && cubit.state is RejectRequestSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم رفض الطلب بنجاح')),
                            );
                            // تحديث الطلبات بعد الرفض (اختياري حسب الحالة)
                            // context.read<GetMyRequestsCubit>().getMyRequests();
                          }
                        },
                  icon: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.cancel, color: Colors.red, size: 30),
                );
              },
            ),
            // زر القبول
            BlocBuilder<ApproveRequestCubit, ApproveRequestState>(
              builder: (context, state) {
                final isLoading = state is ApproveRequestLoading;
                return IconButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final cubit = context.read<ApproveRequestCubit>();
                          await cubit.approveRequest(instractorRequestModel.id!);
                          if (context.mounted && cubit.state is ApproveRequestSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم قبول الطلب بنجاح')),
                            );
                            // تحديث الطلبات بعد القبول (اختياري حسب الحالة)
                            // context.read<GetMyRequestsCubit>().getMyRequests();
                          }
                        },
                  icon: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_circle, color: Colors.green, size: 30),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
