import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomTobic extends StatefulWidget {
  const CustomTobic({super.key});

  @override
  State<CustomTobic> createState() => CustomTobicState();
}

class CustomTobicState extends State<CustomTobic> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, TextEditingController>> _controllersList = [];

  void _addNewTopic() {
    setState(() {
      _controllersList.add({
        'label': TextEditingController(),
        'description': TextEditingController(),
      });
    });
  }

  void _removeTopic(int index) {
    setState(() {
      _controllersList.removeAt(index);
    });
  }

  InputDecoration _bottomBorderDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.regular16().copyWith(color: ColorsBox.grey) ,
      isDense: true,
      contentPadding: const EdgeInsets.only(bottom: 4),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsBox.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: ColorsBox.brightBlue),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr.required_field;
    }
    return null;
  }

  /// ✅ هذه الدالة ترجع البيانات على شكل Map<String, dynamic>
  Map<String, dynamic> getTopicsMap() {
    final Map<String, String> topicsData = {};

    for (var ctrls in _controllersList) {
      final label = ctrls['label']?.text ?? '';
      final desc = ctrls['description']?.text ?? '';
      if (label.isNotEmpty) {
        topicsData[label] = desc;
      }
    }

    return topicsData;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
            itemCount: _controllersList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final controllers = _controllersList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: _bottomBorderDecoration('${context.tr.labelWord} *'),
                          validator: _requiredValidator,
                          controller: controllers['label'],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _removeTopic(index),
                        icon:
                            const Icon(Icons.delete_outline, color: ColorsBox.red),
                      ),
                    ],
                  ),
                  10.ph,
                  CustomTextFormField(
                    hintText: context.tr.descriptionHint,
                    isPrice: false,
                    validator: _requiredValidator,
                    controller: controllers['description'],
                  ),
                  23.ph,
                ],
              );
            },
          ),
          Row(
            children: [
              Text(
                context.tr.tobic,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: context.tr.fontFamilyLora),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: _addNewTopic,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  shape: const CircleBorder(),
                  fixedSize: const Size(25, 25),
                  backgroundColor: ColorsBox.grey.withOpacity(0.4),
                ),
                child: const Icon(Icons.add, color: ColorsBox.black, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
