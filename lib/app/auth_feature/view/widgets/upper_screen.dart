import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

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
      child:  Text(
        'SnapDeals',
        style: AppTextStyles.bold34().copyWith(
          color: ColorsBox.white,
        ),
        
       
      ),
    );
  }
}
