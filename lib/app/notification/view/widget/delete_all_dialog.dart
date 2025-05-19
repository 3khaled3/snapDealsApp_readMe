part of '../notification_view.dart';

void _showDeleteConfirmationDialog(
    BuildContext context, NotificationCubit cubit) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        context.tr.delete_all_notifications,
        style: AppTextStyles.bold18().copyWith(color: ColorsBox.black),
      ),
      content: Text(
        context.tr.are_you_sure_delete,
        style: AppTextStyles.regular16().copyWith(color: ColorsBox.grey700),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.tr.cancel,
            style: AppTextStyles.medium16().copyWith(color: ColorsBox.grey700),
          ),
        ),
        TextButton(
          onPressed: () {
            cubit.deleteAll();
            Navigator.pop(context);
          },
          child: Text(
            context.tr.delete,
            style: AppTextStyles.medium16().copyWith(color: ColorsBox.red),
          ),
        ),
      ],
    ),
  );
}
