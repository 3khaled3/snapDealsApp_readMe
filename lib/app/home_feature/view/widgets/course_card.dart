import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_cubit/add_to_favorite/add_to_favorite_cubit.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_cubit/remove_from_favorite/remove_from_favorite_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/course_details_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(
          CourseDetailsView.routeName,
          extra: CourseDetailsViewArgs(course: course),
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
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// course Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl:
                            course.images.isEmpty ? '' : course.images.first,
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    0.ph,

                    /// course Name
                    Text(
                      course.title,
                      style: AppTextStyles.medium14(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// course Owner (for courses)
                    // if (isCourse == true) ...[

                    Text(
                      course.instructor.name,
                      style: AppTextStyles.semiBold12()
                          .copyWith(color: ColorsBox.greyish),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // ],
                    // 6.ph,

                    /// Rating Row
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < course.ratingsAverage
                                ? Icons.star
                                : Icons.star_half,
                            size: 16,
                            color: Colors.amber,
                          );
                        }),
                        6.pw,
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              course.ratingsQuantity.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.regular12()
                                  .copyWith(color: ColorsBox.greyish),
                            ),
                          ),
                        ),
                      ],
                    ),
                    0.ph,

                    /// course Price
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          '\$${(course.price).toStringAsFixed(2)}',
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
            Positioned(
                top: 12,
                right: 12,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => AddToFavoriteCubit()),
                    BlocProvider(create: (_) => RemoveFromFavoriteCubit()),
                  ],
                  child: _FavoriteButton(productId: course.id),
                )),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final String productId;

  const _FavoriteButton({required this.productId});

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _isFavorite = false;
  late AddToFavoriteCubit addCubit;
  late RemoveFromFavoriteCubit removeCubit;

  @override
  void initState() {
    super.initState();
    addCubit = context.read<AddToFavoriteCubit>();
    removeCubit = context.read<RemoveFromFavoriteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddToFavoriteCubit, AddToFavoriteState>(
          listener: (context, state) {
            if (state is AddToFavoriteSuccess) {
               context.showSuccessSnackBar(
                                  message: 'تمت الإضافة إلى المفضلة',
                                );
            setState(() => _isFavorite = !_isFavorite);
            } else if (state is AddToFavoriteError) {
              context.showErrorSnackBar(
                                  message: 'فشل في الإضافة',
                                );
              
            }
          },
        ),
        BlocListener<RemoveFromFavoriteCubit, RemoveFromFavoriteState>(
          listener: (context, state) {
            if (state is RemoveFromFavoriteSuccess) {
              context.showSuccessSnackBar(
                                  message: ' تمت الازالة بنجاح',
                                );
              setState(() => _isFavorite = !_isFavorite);
            } else if (state is RemoveFromFavoriteError) {
               context.showErrorSnackBar(
                                  message: 'فشل في الإزالة',
                                );
              
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          setState(() => _isFavorite = !_isFavorite);
          if (_isFavorite) {
            addCubit.addToFavorites(widget.productId);
          } else {
            removeCubit.removeFromFavorites(widget.productId);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
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
      ),
    );
  }
}
