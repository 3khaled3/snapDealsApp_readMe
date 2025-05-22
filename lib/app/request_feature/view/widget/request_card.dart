import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/request_feature/data/model/request/request.dart';
import 'package:snap_deals/app/request_feature/view/widget/request_dialog.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
  });

  final RequestModel request;

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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: request.status == 'pending'
                        ? ColorsBox.greyish
                        : request.status == 'accepted'
                            ? ColorsBox.green
                            : ColorsBox.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request.status.toString(),
                    style: AppTextStyles.semiBold14(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    RequestDialogs.cancelRequest(context, request.id!);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            8.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.course?.title ?? 'empty title',
                  style: AppTextStyles.bold16(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                7.ph,
                Text(
                  'ID: ${request.id}',
                  style: AppTextStyles.semiBold12(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                7.ph,
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey),
                    6.pw,
                    Text(
                      formatTime(request.createdAt!),
                      style: AppTextStyles.semiBold14(),
                    ),
                    const Spacer(),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    6.pw,
                    Text(
                      formatDate(request.createdAt!),
                      style: AppTextStyles.semiBold14(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
