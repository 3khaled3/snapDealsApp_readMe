import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_image_slider.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/describtion_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/details_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/main_details_section.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

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
                const MainDetailsSection(
                  price: 'EGP 53,000',
                  brand: 'Samsung',
                  title: 'Samsung Galaxy S24 Ultra',
                  location: 'Zagazig, Sharqia',
                  date: '20/11/2024',
                ),
                15.ph,
                _spaceBetweenSections(),
                15.ph,
                const CustomDetailsGrid(
                  details: {
                    'Condition': 'New',
                    'Style': 'S 24 ultra',
                    'Storage': '256 GB',
                    'RAM': '8 GB',
                    'Color': 'Black',
                  },
                ),
                15.ph,
                _spaceBetweenSections(),
                15.ph,
                const DescribtionSection(
                  description:
                      '【Complete and Professional Art Drawing Supplies Pencils Set with Sketch Pad】, 15 graphite sketch pencils for drawing . 3 black and 3 white, charcoal pencils, 3 graphite and 3 charcoal sticks, 4 willow charcoal, 3 blending stumps',
                ),
                15.ph,
                _spaceBetweenSections(),
                15.ph,
                const ContactSection(name: 'Ziad Tamer')
              ],
            )
          ],
        ),
      ),
    );
  }
}

_spaceBetweenSections() {
  return const Padding(
    padding: EdgeInsets.only(right: 35, left: 35),
    child: Divider(
      thickness: 1,
      color: Colors.black,
    ),
  );
}
