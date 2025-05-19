import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ContactAndPrice extends StatelessWidget {
  const ContactAndPrice({super.key, required this.courseModel});
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsBox.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Price Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: AppTextStyles.regular14().copyWith(
                  color: ColorsBox.blueGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${courseModel.price} EGP',
                style: AppTextStyles.bold18().copyWith(
                  color: ColorsBox.brightBlue,
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),

          // Chat Button
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  startChat(
                      context,
                      Partner(
                        id: courseModel.instructor.id,
                        name: courseModel.instructor.name,
                        profileImg: courseModel.instructor.profileImg,
                        phone: courseModel.instructor.phone,
                      ));
                },
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
                  'Chat now',
                  style: AppTextStyles.semiBold16().copyWith(
                    color: ColorsBox.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
