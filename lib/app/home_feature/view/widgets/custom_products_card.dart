import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomProductCard extends StatelessWidget {
  final String title;

  final String price;
  final String imagePath;
  final String? owner;
  final bool? isCourse;

  const CustomProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
    this.owner,
    this.isCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {},
        child: Card(
          color: ColorsBox.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: ColorsBox.black),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                8.pw,
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      11.ph,
                      Text(title, style: AppTextStyles.medium16()),
                      isCourse == true ? 12.ph : 0.ph,
                      isCourse == true
                          ? Text(owner!,
                              style: AppTextStyles.semiBold16()
                                  .copyWith(color: ColorsBox.greyish))
                          : 0.ph,
                      10.ph,
                      Text(price,
                          style: AppTextStyles.semiBold16()
                              .copyWith(color: ColorsBox.brightBlue)),
                    ],
                  ),
                ),
                15.pw,
              ],
            ),
          ),
        ),
      ),
      const Positioned(
        top: 19,
        right: 7,
        child: _FavoriteButton(),
      ),
    ]);
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
          size: 24,
        ),
      ),
    );
  }
}
