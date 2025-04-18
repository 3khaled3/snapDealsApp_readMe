import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class FavoriteViewArgs {}

class FavoriteView extends StatelessWidget {
  const FavoriteView({this.args, super.key});
  final FavoriteViewArgs? args;

  static const String routeName = '/favorite_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            16.ph,
            Center(
              child: Text(
                context.tr.favoriteView,
                style: AppTextStyles.semiBold20().copyWith(
                  fontFamily: AppTextStyles.fontFamilyLora,
                ),
              ),
            ),
            16.ph,
            Divider(
              color: ColorsBox.greyishTwo,
              height: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title

                    /// Grid View of Products
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 7,
                        itemBuilder: (context, index) => const ProductCard(
                          productName: 'Noise Cancelling Headphones',
                          price: 950,
                          productOwner: "sam sam sam sam sam sam sam ",
                          imagePath:
                              "https://www.onlineprinters.co.uk/magazine/wp-content/uploads/2019/06/image-to-pdf.jpg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
