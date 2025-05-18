import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

import '../../data/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onMarkAsSeen;
  final VoidCallback onDelete;

  const NotificationWidget({
    super.key,
    required this.notification,
    required this.onMarkAsSeen,
    required this.onDelete,
  });

  @override
  createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget>
    with SingleTickerProviderStateMixin {
  late bool isSeen;

  @override
  void initState() {
    super.initState();
    isSeen = widget.notification.isSeen;
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    final now = DateTime.now();
    final difference = now.difference(parsedDate);

    if (difference.inMinutes < 1) {
      return context.tr.just_now;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}${context.tr.minutes_ago}';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}${context.tr.hours_ago}';
    } else {
      return '${difference.inDays}${context.tr.days_ago}';
    }
  }

  void markAsSeen() {
    if (!isSeen) {
      setState(() {
        isSeen = true;
      });
    }
    widget.onMarkAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.notification),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => widget.onDelete(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSeen ? const Color(0xFFF9FAFB) : const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSeen
              ? []
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3))
                ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: markAsSeen,
          onLongPress: widget.onDelete,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated Icon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  isSeen
                      ? Icons.notifications_none
                      : Icons.notifications_active,
                  key: ValueKey<bool>(isSeen),
                  color: isSeen ? ColorsBox.grey700 : Colors.orange,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),

              // Notification Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.notification.title,
                      style: AppTextStyles.bold18().copyWith(
                          color: isSeen ? Colors.black87 : ColorsBox.black),
                    ),
                    const SizedBox(height: 4),

                    // Body
                    Text(
                      widget.notification.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium16()
                          .copyWith(color: ColorsBox.grey700),
                    ),
                    const SizedBox(height: 8),

                    // Date with subtle opacity
                    Text(
                      formatDate(widget.notification.date),
                      style: AppTextStyles.semiBold14()
                          .copyWith(color: ColorsBox.grey700),
                    ),
                  ],
                ),
              ),

              // Unread Indicator (animated)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isSeen
                    ? const SizedBox.shrink()
                    : const Icon(Icons.circle,
                        color: Colors.orange,
                        size: 12,
                        key: ValueKey<bool>(false)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
