import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class LessonsSection extends StatelessWidget {
  const LessonsSection({
    super.key,
    required this.lessons,
  });

  final List<LessonModel> lessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        9.ph,
        Text('Lessons (${lessons.length})', style: AppTextStyles.semiBold20()),
        9.ph,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];

            return Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // TODO: Handle lesson click
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Ink(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: AppTextStyles.regular16()
                                    .copyWith(color: Colors.purple),
                              ),
                            ),
                          ),
                          30.pw,
                          Expanded(
                            child: Text(
                              lesson.title ?? 'Untitled Lesson',
                              style: AppTextStyles.regular16()
                                  .copyWith(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                15.ph,
              ],
            );
          },
        ),
      ],
    );
  }
}
