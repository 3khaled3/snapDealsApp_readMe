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
    return DateFormat('h:mm a', 'en').format(date);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy', 'en').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: ColorsBox.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const Icon(Icons.person, color: Colors.grey),
                8.pw,
                Expanded(
                  child: Text(
                    instractorRequestModel.sender?.name ?? 'Unknown',
                    style: AppTextStyles.bold18(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            16.ph,

            /// Time and Date Row
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey, size: 20),
                6.pw,
                Text(
                  formatTime(instractorRequestModel.createdAt!),
                  style: AppTextStyles.regular14(),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                6.pw,
                Text(
                  formatDate(instractorRequestModel.createdAt!),
                  style: AppTextStyles.regular14(),
                ),
              ],
            ),
            20.ph,

            /// Action Buttons
            Row(
              children: [
                /// Reject Button
                BlocBuilder<RejectRequestCubit, RejectRequestState>(
                  builder: (context, state) {
                    final isLoading = state is RejectRequestLoading;
                    return Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ColorsBox.white,
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading
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
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : Text(context.tr.rejectWord,
                                style: AppTextStyles.semiBold14()),
                      ),
                    );
                  },
                ),
                12.pw,

                /// Approve Button
                BlocBuilder<ApproveRequestCubit, ApproveRequestState>(
                  builder: (context, state) {
                    final isLoading = state is ApproveRequestLoading;
                    return Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ColorsBox.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading
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
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : Text(context.tr.acceptWord,
                                style: AppTextStyles.semiBold14()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
