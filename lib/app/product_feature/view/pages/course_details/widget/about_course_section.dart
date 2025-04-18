import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/desc_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/info_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/instructor_details.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AboutCourseSection extends StatelessWidget {
  const AboutCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.42,
      width: double.infinity,
      child: ListView(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescSection(),
              SizedBox(height: 20),
              InstructorDetails(),
              SizedBox(height: 20),
              Text(
                'Info',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
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
            ],
          ),
          15.ph,
        ],
      ),
    );
  }
}
