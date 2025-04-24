import 'package:flutter/material.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';

extension Localization on BuildContext {
  Tr get tr => Tr.of(this);
  void showErrorSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  void showSuccessSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  void showDefaultSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> showLoadingDialog() async {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
