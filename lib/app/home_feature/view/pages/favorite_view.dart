import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class FavoriteViewArgs {}

class FavoriteView extends StatelessWidget {
  const FavoriteView({this.args, super.key});
  final FavoriteViewArgs? args;
  static const String routeName = '/favorite_route';

  @override
  Widget build(BuildContext context) {
    List<ProductCard> products = [
      const ProductCard(
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        isCourse: false,
      ),
      const ProductCard(
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        isCourse: false,
      ),
      const ProductCard(
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        isCourse: false,
      ),
      const ProductCard(
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        isCourse: false,
      ),
      const ProductCard(
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        isCourse: false,
      ),
      const ProductCard(
        isCourse: true,
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        productOwner: 'Ziad tamer',
      ),
      const ProductCard(
        isCourse: true,
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        productOwner: 'Ziad tamer',
      ),
      const ProductCard(
        isCourse: true,
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        productOwner: 'Ziad tamer',
      ),
      const ProductCard(
        isCourse: true,
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        productOwner: 'Ziad tamer',
      ),
      const ProductCard(
        isCourse: true,
        productName: 'Product Name',
        price: 1000,
        imagePath: AppImageAssets.forgotPassImage,
        productOwner: 'Ziad tamer',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 71, bottom: 80, left: 15, right: 15),
      child: Column(
        children: [
          Center(
              child: Text(
            'Favorite View',
            style: AppTextStyles.semiBold20()
                .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
          )),
          30.ph,
          SizedBox(
              height: 700,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Adjust for the number of columns you want
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7, // Adjust based on the design
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => products[index],
              )),
        ],
      ),
    );
  }
}
