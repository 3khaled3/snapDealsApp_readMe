import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpTextFormField extends StatefulWidget {
  final Function(String)? onSaved;
  final TextEditingController? controller;

  const CustomOtpTextFormField({super.key, this.onSaved, this.controller});

  @override
  State<CustomOtpTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomOtpTextFormField> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 70,
          width: 54,
          child: TextFormField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1)
            ],
            controller: widget.controller,
            onChanged: (value) {
              widget.onSaved!(value);
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            // onSaved: widget.onSaved != null
            //     ? (value) => widget.onSaved!(value!)
            //     : null,
          ),
        );
      },
    );
  }
}