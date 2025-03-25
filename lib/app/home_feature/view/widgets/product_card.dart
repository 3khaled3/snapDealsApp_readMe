import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/your_profile.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productOwner;
  final String imagePath;
  final double price;
  final bool isCourse;
  final double width;
  final double height;

  const ProductCard({
    super.key,
    required this.productName,
    required this.imagePath,
    this.productOwner = '',
    required this.price,
    this.isCourse = false,
    this.width = 180,
    this.height = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(YourProfileView.routeName);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: ColorsBox.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: ColorsBox.greyish),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Image
                    GestureDetector(
                      onTap: () {},
                      child: _ProductImage(imagePath: imagePath),
                    ),

                    /// Product Name
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 8, bottom: 8, start: 4),
                      child: Text(productName, style: AppTextStyles.medium14()),
                    ),

                    /// Product Owner (if applicable)
                    if (isCourse)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 4),
                        child: Text(
                          productOwner,
                          style: AppTextStyles.semiBold12()
                              .copyWith(color: ColorsBox.greyish),
                        ),
                      ),

                    isCourse ? const Spacer() : 17.ph,

                    /// Product Price
                    isCourse
                        ? Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8),
                            child: Text(
                              ' \$200',
                              style: AppTextStyles.semiBold12()
                                  .copyWith(color: ColorsBox.brightBlue),
                            ),
                          )
                        : Center(
                            child: Text(
                              ' \$200',
                              style: AppTextStyles.semiBold12()
                                  .copyWith(color: ColorsBox.brightBlue),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Favorite Button
        const Positioned(
          top: 157,
          right: 12,
          child: _FavoriteButton(),
        ),
      ],
    );
  }
}

/// Product Image
class _ProductImage extends StatelessWidget {
  final String imagePath;
  const _ProductImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}

/// Favorite Button
class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton();

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsBox.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_outlined,
          color: Colors.red,
          size: 16,
        ),
      ),
    );
  }
}
