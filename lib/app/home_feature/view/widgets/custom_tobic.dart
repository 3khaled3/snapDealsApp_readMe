import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomTobic extends StatefulWidget {
  const CustomTobic({super.key});

  @override
  State<CustomTobic> createState() => _CustomTobicState();
}

class _CustomTobicState extends State<CustomTobic> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String?>> _topics = [];

  void _addNewTopic() {
    setState(() {
      _topics.add({"label": ""});
    });
  }

  void _removeTopic(int index) {
    setState(() {
      _topics.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
            itemCount: _topics.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final currentIndex = index;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label field
                  Row(
                    children: [
                      IntrinsicWidth(
                        child: TextFormField(
                          decoration: _bottomBorderDecoration('Label *'),
                          validator: _requiredValidator,
                          onChanged: (value) {
                            _topics[index]['label'] = value;
                          },
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _removeTopic(currentIndex),
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                  10.ph,
                  // Value field
                  CustomTextFormField(
                    hintText: 'Enter describtion',
                    isPrice: false,
                    validator: _requiredValidator,
                  ),
                  23.ph,
                ],
              );
            },
          ),
          Row(
            children: [
              Text(
                'Tobic *',
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  _addNewTopic();
                },
                style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    shape: const CircleBorder(),
                    fixedSize: const Size(25, 25),
                    backgroundColor: ColorsBox.slateGrey),
                child: const Icon(
                  Icons.add,
                  color: ColorsBox.black,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
