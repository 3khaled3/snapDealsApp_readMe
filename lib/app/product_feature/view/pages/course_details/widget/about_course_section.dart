import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/desc_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/info_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/instructor_details.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AboutCourseSection extends StatelessWidget {
  final CourseModel course;

  const AboutCourseSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final entries = course.details.entries.toList();

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.42,
      width: double.infinity,
      child: ListView(
        padding: const EdgeInsets.all(0),
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescSection(description: course.description),
              const SizedBox(height: 20),
              InstructorDetails(instructor: course.instructor),
              const SizedBox(height: 20),
              const Text(
                'Info',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 40,
                runSpacing: 15,
                children: [
                  InfoItem(
                      title: "Language", value: course.language ?? "Unknown"),
                  ...entries.expand((e) {
                    final value = e.value;
                    if (value is Map) {
                      return value.entries.map((subEntry) => InfoItem(
                          title: subEntry.key,
                          value: subEntry.value.toString()));
                    } else {
                      return [InfoItem(title: e.key, value: value.toString())];
                    }
                  }),
                ],
              ),
            ],
          ),
          8.ph,
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsBox.brightBlue,
                foregroundColor: ColorsBox.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                elevation: 2,
              ),
              child: Text(
                context.tr.make_request,
                style: AppTextStyles.semiBold16().copyWith(
                  color: ColorsBox.white,
                ),
              ),
            ),
          ),
          15.ph,
        ],
      ),
    );
  }
}
