import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
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
        Text(
          context.tr.instructor,
          style: AppTextStyles.semiBold16(),
        ),
        12.ph,
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (instructor.profileImg != null &&
                      instructor.profileImg!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: instructor.profileImg ??
                          "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg",
                      placeholder: (context, url) => _defaultProfileImage(),
                      errorWidget: (context, url, error) =>
                          _defaultProfileImage(),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : _defaultProfileImage(),
            ),

            14.pw,

            // Name & Phone
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instructor.name,
                    style: AppTextStyles.semiBold16(),
                  ),
                  if (instructor.phone != null && instructor.phone!.isNotEmpty)
                    Text(
                      instructor.phone!,
                      style: AppTextStyles.regular14()
                          .copyWith(color: ColorsBox.grey),
                    ),
                ],
              ),
            ),
            if (instructor.id != ProfileCubit.instance.state.profile.id) ...[
              if (instructor.phone != null && instructor.phone!.isNotEmpty)
                _circleIconButton(
                  icon: Icons.call,
                  onTap: () => callInstructor(instructor.phone!),
                ),
              12.pw,
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
                      role: Role.user,
                    ),
                  );
                },
              ),
            ]
            // Call & Chat Buttons
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
