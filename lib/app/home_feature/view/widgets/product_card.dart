import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Ink(
        height: 280,
        width: 180,
        decoration: BoxDecoration(
            color: ColorsBox.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: ColorsBox.greyish)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// <---- product image ---->///
              GestureDetector(
                child: const _ProductImage(),
                onTap: () {},
              ),

              /// <---- product name ---->///
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 8, bottom: 8, start: 4),
                    child:
                        Text("product Name", style: AppTextStyles.medium14()),
                  ),

                  /// <---- favorite button ---->///
                  const _FavoriteButton(),
                ],
              ),

              /// <---- product`s owner ---->///
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 8, bottom: 8, start: 4),
                child: Text("product owner",
                    style: AppTextStyles.semiBold12()
                        .copyWith(color: ColorsBox.greyish)),
              ),

              /// <---- Rating ---->///

              // const _Rating(),
              const Spacer(),

              /// <---- product price ---->///
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                child: Text(' \$200',
                    style: AppTextStyles.semiBold12()
                        .copyWith(color: ColorsBox.brightBlue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// <---- product image ---->///
class _ProductImage extends StatelessWidget {
  const _ProductImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 150,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImageAssets.forgotPassImage,
              ))),
    );
  }
}

/// <---- rating ---->///
class _Rating extends StatefulWidget {
  const _Rating();

  @override
  State<_Rating> createState() => _RatingState();
}

class _RatingState extends State<_Rating> {
  bool rate1 = false;
  bool rate2 = false;
  bool rate3 = false;
  bool rate4 = false;
  bool rate5 = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("4.5",
            style: AppTextStyles.semiBold12().copyWith(color: ColorsBox.black)),
        0.2.pw,
        IconButton(
          onPressed: () {
            setState(() {
              rate1 = true;
            });
          },
          icon: Icon(rate1 ? Icons.star : Icons.star_border_outlined,
              color: ColorsBox.sunYellow),
        ),
        0.2.pw,
        IconButton(
          onPressed: () {
            setState(() {
              rate2 = !rate2;
            });
          },
          icon: Icon(rate2 ? Icons.star : Icons.star_border_outlined,
              color: ColorsBox.sunYellow),
        ),
        0.2.pw,
        IconButton(
          onPressed: () {
            setState(() {
              rate3 = !rate3;
            });
          },
          icon: Icon(rate3 ? Icons.star : Icons.star_border_outlined,
              color: ColorsBox.sunYellow),
        ),
        0.2.pw,
        IconButton(
          onPressed: () {
            setState(() {
              rate4 = !rate4;
            });
          },
          icon: Icon(rate4 ? Icons.star : Icons.star_border_outlined,
              color: ColorsBox.sunYellow),
        ),
        0.2.pw,
        IconButton(
          onPressed: () {
            setState(() {
              rate5 = !rate5;
            });
          },
          icon: Icon(rate5 ? Icons.star : Icons.star_border_outlined,
              color: ColorsBox.sunYellow),
        ),
        0.2.pw,
        Text(
          '(500)',
          style: AppTextStyles.medium12().copyWith(color: ColorsBox.greyish),
        )
      ],
    );
  }
}

/// <---- favorite button ---->///
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
          _isFavorite ? Icons.favorite_border_outlined : Icons.favorite_rounded,
          color: Colors.red,
          size: 16,
        ),
      ),
    );
  }
}
