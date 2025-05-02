import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/product_details_view.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final String productName = product.title;
    final double price = product.price;
    final Partner productOwner = product.user;
    final String imagePath =
        product.images.isNotEmpty ? product.images.first : "";

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          ProductDetailsView.routeName,
          extra: ProductDetailsArgs(product: product),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Stack(
          children: [
            Container(
              height: 280,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorsBox.white,
                border: Border.all(color: ColorsBox.greyish.withOpacity(0.4)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          AppImageAssets.onboardingImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    0.ph,

                    /// Product Name
                    Text(
                      productName,
                      style: AppTextStyles.medium14(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Product Owner (for courses)
                    // if (isCourse == true) ...[

                    Text(
                      productOwner.name,
                      style: AppTextStyles.semiBold12()
                          .copyWith(color: ColorsBox.greyish),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    0.ph,

                    /// Product Price
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          '\$${(price).toStringAsFixed(2)}',
                          maxLines: 1,
                          style: AppTextStyles.semiBold14().copyWith(
                            color: ColorsBox.brightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Favorite Button
            const Positioned(
              top: 12,
              right: 12,
              child: _FavoriteButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton();

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isFavorite = !_isFavorite),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: ColorsBox.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          _isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
          color: _isFavorite ? Colors.red : Colors.grey,
          size: 18,
        ),
      ),
    );
  }
}
