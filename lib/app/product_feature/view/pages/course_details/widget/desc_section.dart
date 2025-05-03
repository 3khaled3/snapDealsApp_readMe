import 'package:flutter/material.dart';

class DescSection extends StatelessWidget {
  const DescSection({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Course",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
