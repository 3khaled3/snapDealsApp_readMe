import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_deals/core/extensions/context_extension.dart'; // ضروري لاستخدام Clipboard

class CustomCopyButton extends StatelessWidget {
  final String textToCopy; // النص الذي سيتم نسخه

  const CustomCopyButton({super.key, required this.textToCopy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: textToCopy));
        context.showSuccessSnackBar(
          message: context.tr.copyTextSuccess,
        );
      },
      child: const Icon(
        Icons.copy,
        color: Colors.blueGrey,
        size: 20,
      ),
    );
  }
}
