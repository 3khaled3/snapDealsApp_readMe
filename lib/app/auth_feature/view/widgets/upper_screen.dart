import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpperScreen extends StatelessWidget {
  const UpperScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(top: 120, left: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.jpeg'),
        ),
      ),
      child: const Text(
        'SnapDeals',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Lora',
        ),
      ),
    );
  }
}
