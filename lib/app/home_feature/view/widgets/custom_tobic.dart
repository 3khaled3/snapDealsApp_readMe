import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
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
      hintStyle: const TextStyle(color: Colors.grey),
      isDense: true,
      contentPadding: const EdgeInsets.only(bottom: 4),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
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

  return {
    'topics': topicsData,
  };
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
                          decoration: _bottomBorderDecoration('Label *'),
                          validator: _requiredValidator,
                          controller: controllers['label'],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _removeTopic(index),
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                  10.ph,
                  CustomTextFormField(
                    hintText: 'Enter description',
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
                'Topic *',
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: _addNewTopic,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  shape: const CircleBorder(),
                  fixedSize: const Size(25, 25),
                  backgroundColor: ColorsBox.slateGrey,
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
