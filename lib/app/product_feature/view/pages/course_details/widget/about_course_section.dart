import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/desc_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/info_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/instructor_details.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AboutCourseSection extends StatelessWidget {
  const AboutCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DescSection(),
            20.ph,
            const InstructorDetails(),
            20.ph,
            const Text(
              'Info',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            10.ph,
            const Wrap(
              spacing: 40,
              runSpacing: 15,
              children: [
                InfoItem(title: "Students", value: "15,231"),
                InfoItem(title: "Language", value: "English"),
                InfoItem(title: "Last update", value: "Feb 2, 2024"),
                InfoItem(title: "Subtitle", value: "English and 2 more"),
                InfoItem(title: "Level", value: "Beginner"),
                InfoItem(title: "Access", value: "Mobile, Desktop"),
              ],
            ),
            15.ph,
          ],
        ),
      ),
    );
  }
}
