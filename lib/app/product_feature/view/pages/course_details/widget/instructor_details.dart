import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({super.key, required this.courseModel});
  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    final instructor = courseModel.instructor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Instructor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (instructor.profileImg != null &&
                      instructor.profileImg!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: instructor.profileImg!,
                      placeholder: (context, url) => _defaultProfileImage(),
                      errorWidget: (context, url, error) =>
                          _defaultProfileImage(),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : _defaultProfileImage(),
            ),

            const SizedBox(width: 14),

            // Name & Phone
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instructor.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  if (instructor.phone != null && instructor.phone!.isNotEmpty)
                    Text(
                      instructor.phone!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),

            // Call & Chat Buttons
            if (instructor.phone != null && instructor.phone!.isNotEmpty)
              _circleIconButton(
                icon: Icons.call,
                onTap: () => callInstructor(instructor.phone!),
              ),
            const SizedBox(width: 12),
            _circleIconButton(
              icon: Icons.message_outlined,
              onTap: () {
                startChat(
                  context,
                  Partner(
                    id: instructor.id,
                    name: instructor.name,
                    profileImg: instructor.profileImg,
                    phone: instructor.phone,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // Default profile fallback widget
  Widget _defaultProfileImage() {
    return SvgPicture.asset(
      AppImageAssets.defaultProfile,
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    );
  }

  // Reusable circular icon button
  Widget _circleIconButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: ColorsBox.mainColor.withOpacity(0.1),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 22,
            color: ColorsBox.mainColor,
          ),
        ),
      ),
    );
  }
}

Future<void> callInstructor(String phoneNumber) async {
  final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    // Optionally show an error dialog/snackbar
    throw 'Could not launch $uri';
  }
}
