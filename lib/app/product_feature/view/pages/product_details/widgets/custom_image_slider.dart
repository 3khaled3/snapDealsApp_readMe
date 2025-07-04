import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/on_board_feature/view/widget/page_indicator.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/delete_course_cubit/delete_course_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/delete_product_cubit/delete_product_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/edit_product.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/product_details_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomImageSlider extends StatefulWidget {
  const CustomImageSlider(
      {super.key,
      required this.images,
      required this.userId,
      required this.productId,
      required this.isProduct,
      this.product,
      this.course});
  final List<String> images;
  final String userId;
  final String productId;
  final bool isProduct;
  final CourseModel? course;
  final ProductModel? product;
  @override
  createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  final DeleteProductCubit deleteProductCubit = DeleteProductCubit();
  // final DeleteCourseCubit deleteCourseCubit = DeleteCourseCubit();

  int _currentIndex = 0;
  final user = ProfileCubit.instance.state.profile;
  bool get isAdmin => user.role == Role.admin;
  bool get isOwner => user.id == widget.userId;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 300,
              child: Hero(
                tag: widget.product != null
                    ? 'product-${widget.product!.id}'
                    : 'course-${widget.course!.id}',
                child: PageView.builder(
                  itemCount: widget.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: ColorsBox.greyReceivedMessage,
                        highlightColor: ColorsBox.paleGrey,
                        child: Container(
                          color: ColorsBox.white,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
            8.ph,
            PageIndicator(
              currentPage: _currentIndex,
              pageLength: widget.images.length,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 8, vertical: MediaQuery.paddingOf(context).top),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsBox.black,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: ColorsBox.white, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsetsDirectional.only(start: 8),
              constraints: const BoxConstraints(),
            ),
          ),
        ),
        if (isAdmin || isOwner)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8, vertical: MediaQuery.paddingOf(context).top),
            child: Align(
              alignment: context.tr.lang == "en"
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isAdmin
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsBox.black,
                          ),
                          child: IconButton(
  icon: const Icon(Icons.edit, color: ColorsBox.white, size: 20),
 onPressed: () async {
 print('Edit button pressed - Original product: ${widget.product?.title}');
 
 print('About to push to EditDetailsView');
 
 // Use push with await to handle returned data
 final result = await GoRouter.of(context).push(
  EditDetailsView.routeName,
  extra: EditDetailsArgs( widget.product),
);

print('EditDetailsView returned: $result');

// If we got back an updated product, navigate to ProductDetailsView with the new data
if (result != null && result is ProductModel) {
  print('Received updated product: ${result.title}');
  print('Updated product price: ${result.price}');
  
  // Navigate to ProductDetailsView with the updated product
  GoRouter.of(context).pushReplacement(
    ProductDetailsView.routeName,
    extra: ProductDetailsArgs(product: result),
  );
  
  print('Navigated to ProductDetailsView with updated data');
} else {
  print('No updated product returned from EditDetailsView');
}

},

  padding: const EdgeInsetsDirectional.only(start: 8),
  constraints: const BoxConstraints(),
),

                        )
                      : 0.pw,
                  10.pw,
                  BlocListener<DeleteProductCubit, DeleteProductState>(
                    bloc: deleteProductCubit,
                    listener: (context, state) {
                      if (widget.isProduct){
                      if (state is DeleteProductLoading) {
                        context.showLoadingDialog();
                      } else if (state is DeleteProductSuccess) {
                        Navigator.of(context).pop();
                        context.showSuccessSnackBar(
                          message: context.tr.delete_product_success,
                        );
                         GoRouter.of(context).pushReplacement(
                                      MainHomeView.routeName,
                                      extra: MainHomeViewArgs());

                      } else if (state is DeleteProductError) {
                        Navigator.of(context).pop();
                        context.showErrorSnackBar(
                          message: context.tr.delete_product_error,
                        );
                      }}
                      else {
                        if (state is DeleteCourseLoading) {
                          context.showLoadingDialog();
                        } else if (state is DeleteCourseSuccess) {
                          Navigator.of(context).pop();
                          context.showSuccessSnackBar(
                            message: context.tr.delete_product_success,
                          );
                           GoRouter.of(context).pushReplacement(
                                      MainHomeView.routeName,
                                      extra: MainHomeViewArgs());
                        } else if (state is DeleteCourseError) {
                          Navigator.of(context).pop();
                          context.showErrorSnackBar(
                            message: context.tr.delete_product_error,
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsBox.black,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: ColorsBox.red, size: 23),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: ColorsBox.white,
                              content: Text(context.tr.delete_item_label),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(context.tr.cancelWord),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(context.tr.deleteWord,
                                      style: AppTextStyles.regular14()
                                          .copyWith(
                                        color: ColorsBox.red,
                                      )),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            if (widget.isProduct) {
                              deleteProductCubit
                                  .deleteProduct(widget.productId);
                            } else {
                              deleteProductCubit.deleteCourse(widget.productId);
                            }
                          }
                        },
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentIndex == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? ColorsBox.brightBlue : ColorsBox.grey,
      ),
    );
  }
}
