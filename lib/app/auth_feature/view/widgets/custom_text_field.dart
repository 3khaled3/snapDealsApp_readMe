import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

import '../../../../core/themes/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onSaved;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = widget.isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          keyboardType: widget.keyboardType ?? TextInputType.text,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelStyle:
                AppTextStyles.regular16().copyWith(color: ColorsBox.black),
            helperStyle:
                AppTextStyles.regular16().copyWith(color: ColorsBox.greyish),
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.blue,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : widget.suffixIcon != null
                    ? Icon(
                        widget.suffixIcon,
                        color: Colors.blue,
                      )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onChanged: widget.onChanged,
          onSaved: widget.onSaved != null
              ? (value) => widget.onSaved!(value!)
              : null,
          validator: (value) => widget.validator!(value),
        );
      },
    );
  }
}
