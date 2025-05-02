import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_image_slider.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/description_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/details_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/main_details_section.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class ProductDetailsArgs {
  final ProductModel product;
  ProductDetailsArgs({required this.product});
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.args});
  final ProductDetailsArgs args;
  static const String routeName = '/product_details_route';
  @override
  Widget build(BuildContext context) {
    final product = args.product;
    final formattedPrice = 'EGP ${product.price.toStringAsFixed(2)}';
    final formattedDate =
        '${product.createdAt.day}/${product.createdAt.month}/${product.createdAt.year}';
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomImageSlider(images: product.images),
            19.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainDetailsSection(
                  price: formattedPrice,
                  // brand: product.category.name,
                  title: product.title,
                  location: product.location,
                  date: formattedDate,
                ),
                18.ph,
                if (product.details.isNotEmpty) ...[
                  CustomDetailsGrid(details: product.details),
                  18.ph,
                ],
                if (product.description.isNotEmpty)
                  DescriptionSection(description: product.description),
                18.ph,
                ContactSection(user: product.user)
              ],
            )
          ],
        ),
      ),
    );
  }
}
