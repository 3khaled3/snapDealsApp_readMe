import 'package:flutter/material.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instructor",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(AppImageAssets.profileImage),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reda Ahmed",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Design Instructor",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
