import 'package:flutter/material.dart';
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
                Text(
                  'ID: ${request.id}',
                  style: AppTextStyles.bold12(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    RequestDialogs.cancelRequest(context, request.id!);
                  },
                  icon: const Icon(
                    Icons.delete,
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
                  request.course!.title ?? 'empty title',
                  style: AppTextStyles.bold16(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                7.ph,
                Text(
                  request.status.toString(),
                  style: AppTextStyles.semiBold14(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                7.ph,
                Text(
                  request.createdAt.toString(),
                  style: AppTextStyles.semiBold14(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
