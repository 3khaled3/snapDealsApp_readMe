import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class AboutCourseSection extends StatelessWidget {
  const AboutCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About Course",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Animations and Transitions: Learn how to add motion to the interface to improve user feedback, guide users, or make tasks more enjoyable.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        const Text(
          "Instructor",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Row(
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
        const SizedBox(height: 20),
        const Text(
          'Info',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
        20.ph,
        //TODO price and chat button
      ],
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
