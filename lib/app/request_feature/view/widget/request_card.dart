import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/request_feature/data/model/request/request.dart';
import 'package:snap_deals/app/request_feature/view/widget/request_dialog.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request});
  final RequestModel request;

  String formatTime(DateTime date) {
    return DateFormat('h:mm a', Tr.current.lang).format(date);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy', Tr.current.lang).format(date);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return  ColorsBox.green;
      case 'rejected':
        return ColorsBox.red;
      case 'cancelled':
        return const Color(0xFF95A5A6);
      default:
        return const Color(0xFFBDC3C7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsBox.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Status and Cancel
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status ?? ''),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request.status?.toUpperCase() ?? '',
                    style: AppTextStyles.semiBold12()
                        .copyWith(color: ColorsBox.white),
                  ),
                ),
                const Spacer(),
                Tooltip(

                  message: context.tr.cancel_request,
                  textStyle: AppTextStyles.regular12(),
                  child: InkWell(
                    onTap: () =>
                        RequestDialogs.cancelRequest(context, request.id!),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.cancel_outlined, color: ColorsBox.red),
                    ),
                  ),
                ),
              ],
            ),
            12.ph,

            /// Course Title
            Text(
              request.course?.title ?? context.tr.no_course_title,
              style: AppTextStyles.bold16().copyWith(fontSize: 17),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            8.ph,

            /// Request ID
            Text(
              '${context.tr.request_id} ${request.id}',
              style:
                  AppTextStyles.semiBold12().copyWith(color: ColorsBox.grey700),
            ),

            12.ph,

            /// Date & Time Row
            Row(
              children: [
                const Icon(Icons.access_time, color: ColorsBox.grey, size: 20),
                6.pw,
                Text(
                  formatTime(request.createdAt!),
                  style: AppTextStyles.regular12(),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: ColorsBox.grey, size: 20),
                6.pw,
                Text(
                  formatDate(request.createdAt!),
                  style: AppTextStyles.regular12(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
