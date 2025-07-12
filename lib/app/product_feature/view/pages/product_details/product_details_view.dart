import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/contact_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_image_slider.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/description_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/details_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/main_details_section.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class ProductDetailsArgs {
  final ProductModel product;
  ProductDetailsArgs({required this.product});
}

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.args});
  final ProductDetailsArgs args;
  static const String routeName = '/product_details_route';

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    print(
        'ProductDetailsView initialized with product: ${widget.args.product.title}');
    print('Product price: ${widget.args.product.price}');
    print('Product details: ${widget.args.product.details}');
    print('Product updatedAt: ${widget.args.product.updatedAt}');
    print('Product ID: ${widget.args.product.id}');
    print('Product hash: ${widget.args.product.hashCode}');
    print('Widget hash: ${widget.hashCode}');
  }

  @override
  void didUpdateWidget(ProductDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('ProductDetailsView didUpdateWidget called');
    print('Old product: ${oldWidget.args.product.title}');
    print('New product: ${widget.args.product.title}');
    print('Old price: ${oldWidget.args.product.price}');
    print('New price: ${widget.args.product.price}');
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.args.product;

    print('ProductDetailsView building with product: ${product.title}');
    print('ProductDetailsView building with price: ${product.price}');
    print('ProductDetailsView building with updatedAt: ${product.updatedAt}');
    print('ProductDetailsView building with ID: ${product.id}');

    final formattedPrice = product.price == 0
        ? context.tr.free
        : 'EGP ${product.price.toStringAsFixed(2)}';
    final formattedDate =
        '${product.createdAt.day}/${product.createdAt.month}/${product.createdAt.year}';

    // Create a unique key that changes when the product data changes
    final uniqueKey = ValueKey(
        'product_details_${product.id}_${product.title}_${product.price}_${product.updatedAt.millisecondsSinceEpoch}');

    return Scaffold(
      key: uniqueKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomImageSlider(
              product: product,
              images: product.images,
              userId: product.user.id,
              productId: product.id,
              isProduct: true,
            ),
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
                if (product.user.id != ProfileCubit.instance.state.profile.id)
                  ContactSection(user: product.user)
              ],
            )
          ],
        ),
      ),
    );
  }
}
