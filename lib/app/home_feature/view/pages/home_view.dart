import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/categories_avatar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/home_app_bar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class HomeViewArgs {
  //todo add any parameters you need
}

class HomeView extends StatelessWidget {
  const HomeView({this.args, super.key});
  final HomeViewArgs? args;
  static const String routeName = '/home_route';

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
    ];
    List<ProductCard> courses = [
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
      padding: const EdgeInsets.only(left: 9, right: 9, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          55.ph,
          const HomeAppBar('User name'),
          27.ph,
          const Center(child: CategoriesAvatar()),
          18.ph,
          CustomTextFormField(
            hintText: context.tr.hintSearch,
            suffixIcon: Icons.search,
          ),
          26.ph,
          Text(
            context.tr.popularCourse,
            style: AppTextStyles.medium20()
                .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
          ),
          23.ph,
          SizedBox(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) => Row(
                      children: [products[index]],
                    )),
          ),
          27.ph,
          Text(
            context.tr.popularProduct,
            style: AppTextStyles.medium20()
                .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
          ),
          23.ph,
          SizedBox(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) => Row(
                      children: [courses[index]],
                    )),
          ),
        ],
      ),
    );
  }
}
