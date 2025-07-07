import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddLesson extends StatefulWidget {
  const CustomAddLesson({super.key});

  @override
  State<CustomAddLesson> createState() => CustomAddLessonState();
}

class CustomAddLessonState extends State<CustomAddLesson> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _descriptionControllers = [];

  void _addNewLesson() {
    setState(() {
      _descriptionControllers.add(TextEditingController());
    });
  }

  void _removeLesson(int index) {
    setState(() {
      _descriptionControllers.removeAt(index);
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr.required_field;
    }
    return null;
  }

  /// ✅ تُرجع قائمة بعناوين الدروس فقط
  List<String> getLessonsTitles() {
    return _descriptionControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
            itemCount: _descriptionControllers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${context.tr.lesson} ${index + 1}',
                        style: AppTextStyles.semiBold12()
                            .copyWith(fontFamily: context.tr.fontFamilyLora),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _removeLesson(index),
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                  10.ph,
                  CustomTextFormField(
                    hintText: context.tr.add_lesson_title_hint,
                    isPrice: false,
                    validator: _requiredValidator,
                    controller: _descriptionControllers[index],
                  ),
                  23.ph,
                ],
              );
            },
          ),
          Row(
            children: [
              Text(
                context.tr.lesson,
                style: AppTextStyles.semiBold12()
                    .copyWith(fontFamily: context.tr.fontFamilyLora),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: _addNewLesson,
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
