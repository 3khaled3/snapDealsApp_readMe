import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/desc_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/info_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/instructor_details.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AboutCourseSection extends StatelessWidget {
  final CourseModel course;

  const AboutCourseSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final entries = course.details.entries.toList();

    return SizedBox(
      // height: MediaQuery.sizeOf(context).height * 0.42,
      width: double.infinity,
      child: Column(
        // padding: const EdgeInsets.all(0),
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescSection(description: course.description),
              20.ph,
              if (course.instructor.id !=
                  ProfileCubit.instance.state.profile.id)
                InstructorDetails(courseModel: course),
              20.ph,
               Text(
                context.tr.info,
                style: AppTextStyles.bold16(),
               
              ),
              10.ph,
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
          15.ph,
        ],
      ),
    );
  }
}
