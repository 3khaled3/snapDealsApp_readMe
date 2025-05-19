import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/request_feature/model_view/cancel_request_cubit/cancel_request_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class RequestDialogs {
  static void cancelRequest(BuildContext context, String requestId) {
    final cubit = BlocProvider.of<CancelRequestCubit>(context);

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text(context.tr.cancel_request),
          content: Text(context.tr.cancel_request_hint),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.tr.cancelWord),
            ),
            BlocBuilder<CancelRequestCubit, CancelRequestState>(
              builder: (context, state) {
                final isLoading = state is CancelRequestLoading;

                return TextButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          await cubit.cancelRequest(requestId);
                          if (context.mounted &&
                              cubit.state is CancelRequestSuccess) {
                            Navigator.pop(dialogContext);
                          }
                          // يمكنك هنا عمل refresh أو إعادة تحميل للبيانات
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          context.tr.confirmWord,
                          style: const TextStyle(color: Colors.red),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
