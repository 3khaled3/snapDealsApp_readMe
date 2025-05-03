import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/desc_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/info_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/instructor_details.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

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
        physics: const NeverScrollableScrollPhysics(),
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
                  ...entries.map((e) => InfoItem(title: e.key, value: e.value))
                ],
              ),
            ],
          ),
          15.ph,
        ],
      ),
    );
  }
}
