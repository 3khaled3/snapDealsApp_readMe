import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:uuid/uuid.dart';

class CustomEditLesson extends StatefulWidget {
  final List<LessonModel>? initialLessons;

  const CustomEditLesson({super.key, this.initialLessons});

  @override
  State<CustomEditLesson> createState() => CustomEditLessonState();
}

class CustomEditLessonState extends State<CustomEditLesson> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _lessonControllers = [];

  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.initialLessons != null) {
      for (var lesson in widget.initialLessons!) {
        _lessonControllers.add({
          'id': lesson.id,
          'controller': TextEditingController(text: lesson.title),
        });
      }
    }
  }

  void _addNewLesson() {
    setState(() {
      _lessonControllers.add({
        'id': uuid.v4(), // ID مؤقت وفريد
        'controller': TextEditingController(),
      });
    });
  }

  void _removeLesson(int index) {
    setState(() {
      _lessonControllers.removeAt(index);
    });
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr.required_field;
    }
    return null;
  }

  /// تُرجع قائمة الدروس فقط إذا كانت صالحة
  List<LessonModel>? getLessonsList() {
    if (!validateLessonsForm()) return null;

    return _lessonControllers.map((lessonData) {
      final controller = lessonData['controller'] as TextEditingController;
      final id = lessonData['id'] as String;
      return LessonModel(id: id, title: controller.text.trim());
    }).toList();
  }

  bool validateLessonsForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListView.builder(
            itemCount: _lessonControllers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final controller = _lessonControllers[index]['controller'] as TextEditingController;
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
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                  10.ph,
                  CustomTextFormField(
                    hintText: context.tr.add_lesson_title_hint,
                    isPrice: false,
                    validator: _requiredValidator,
                    controller: controller,
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
