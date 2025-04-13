import 'package:flutter/material.dart';

class DescSection extends StatelessWidget {
  const DescSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Course",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Animations and Transitions: Learn how to add motion to the interface to improve user feedback, guide users, or make tasks more enjoyable.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
