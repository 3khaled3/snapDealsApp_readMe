import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({super.key, required this.instructor});
  final Instructor instructor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instructor",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: (instructor.profileImg != null &&
                      instructor.profileImg!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: instructor.profileImg!,
                      placeholder: (context, url) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        AppImageAssets.defaultProfile,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      AppImageAssets.defaultProfile,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  instructor.phone ?? '',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
