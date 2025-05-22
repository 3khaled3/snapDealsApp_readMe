import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/request_feature/data/model/instractor/instractor.request.model.dart';
import 'package:snap_deals/app/request_feature/model_view/approve_request_cubit/approve_request_cubit.dart';
import 'package:snap_deals/app/request_feature/model_view/reject_request_cubit/reject_request_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class InstractorRequestCard extends StatelessWidget {
  const InstractorRequestCard(
      {super.key, required this.instractorRequestModel});
  final InstractorRequestModel instractorRequestModel;

  String formatTime(DateTime date) {
    final DateFormat timeFormatter = DateFormat('h:mm a', 'en');
    return timeFormatter.format(date);
  }

  String formatDate(DateTime date) {
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy', 'en');
    return dateFormatter.format(date);
  }

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' ${instractorRequestModel.sender?.name ?? "Unknown"}',
              style: AppTextStyles.bold18(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey),
                6.pw,
                Text(
                  formatTime(instractorRequestModel.createdAt!),
                  style: AppTextStyles.semiBold14(),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: Colors.grey),
                6.pw,
                Text(
                  formatDate(instractorRequestModel.createdAt!),
                  style: AppTextStyles.semiBold14(),
                ),
              ],
            ),
          ),
          12.ph,
          Row(
            children: [
              // زر الرفض
              BlocBuilder<RejectRequestCubit, RejectRequestState>(
                builder: (context, state) {
                  final isLoading = state is RejectRequestLoading;
                  return Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: isLoading
                            ? null
                            : () async {
                                final cubit =
                                    context.read<RejectRequestCubit>();
                                await cubit
                                    .rejectRequest(instractorRequestModel.id!);
                                if (context.mounted &&
                                    cubit.state is RejectRequestSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('تم رفض الطلب بنجاح')),
                                  );
                                }
                              },
                        child: Ink(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Center(
                                  child: Text(
                                    context.tr.rejectWord,
                                    style: AppTextStyles.semiBold14()
                                        .copyWith(color: ColorsBox.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // 2.pw,

              // زر القبول
              BlocBuilder<ApproveRequestCubit, ApproveRequestState>(
                builder: (context, state) {
                  final isLoading = state is ApproveRequestLoading;
                  return Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: isLoading
                            ? null
                            : () async {
                                final cubit =
                                    context.read<ApproveRequestCubit>();
                                await cubit
                                    .approveRequest(instractorRequestModel.id!);
                                if (context.mounted &&
                                    cubit.state is ApproveRequestSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('تم قبول الطلب بنجاح')),
                                  );
                                }
                              },
                        child: Ink(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Center(
                                  child: Text(
                                    context.tr.acceptWord,
                                    style: AppTextStyles.semiBold14()
                                        .copyWith(color: ColorsBox.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
