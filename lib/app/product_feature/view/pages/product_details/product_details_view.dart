import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_image_slider.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/details_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/main_details_section.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ProductDetailsArgs {}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, this.args});
  final ProductDetailsArgs? args;
  static const String routeName = '/product_details_route';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomImageSlider(),
            19.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainDetailsSection(),
                15.ph,
                const Padding(
                  padding: EdgeInsets.only(right: 35, left: 35),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),

                const DetailsSection(
                  details: {
                    'Condition': 'New',
                    'Style': 'S 24 ultra',
                    'Storage': '256 GB',
                    'RAM': '8 GB',
                  },
                ),
                15.ph,
                const Padding(
                  padding: EdgeInsets.only(right: 35, left: 35),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                15.ph,
                Text(
                  context.tr.describtionWord,
                  style: AppTextStyles.medium20().copyWith(
                    fontFamily: AppTextStyles.fontFamilyLora,
                    color: ColorsBox.brightBlue,
                  ),
                ),
                15.ph,
                Text(
                  '【Complete and Professional Art Drawing Supplies Pencils Set with Sketch Pad】, 15 graphite sketch pencils for drawing . 3 black and 3 white, harcoal pencils, 3 graphite and 3 charcoal sticks, 4 willow charcoal, 3 blending stumps',
                  style: AppTextStyles.regular16()
                      .copyWith(color: ColorsBox.black),
                ),
                //TODO: Add row button to chat with seller
              ],
            )
          ],
        ),
      ),
    );
  }
}
