import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_details_title.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_image.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_tobic.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/update_product_cubit/update_product_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/product_details_view.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_edit_topic.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';

class EditDetailsArgs {
  final ProductModel? product;

  EditDetailsArgs(this.product);
}

class EditDetailsView extends StatefulWidget {
  const EditDetailsView({super.key, this.args});
  static const String routeName = '/edit_product_route';
  final EditDetailsArgs? args;

  @override
  State<EditDetailsView> createState() => _EditDetailsViewState();
}

class _EditDetailsViewState extends State<EditDetailsView> {
  final GlobalKey<CustomTobicState> topicsKey = GlobalKey<CustomTobicState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController brandController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;

  List<XFile> selectedImages = [];
  List<String> oldImages = [];

  UpdateProductCubit updateProductCubit = UpdateProductCubit();

// تحويل Map<String, dynamic> إلى Map<String, String> بشكل آمن:
  Map<String, String> initialTopics = {};
  
  // Store the updated product locally
  ProductModel? localUpdatedProduct;
  
  // Flag to prevent multiple navigation calls
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    final p = widget.args?.product;

    brandController = TextEditingController(text: p?.slug ?? '');
    titleController = TextEditingController(text: p?.title ?? '');
    descriptionController = TextEditingController(text: p?.description ?? '');
    locationController = TextEditingController(text: p?.location ?? '');
    priceController = TextEditingController(text: p?.price.toString() ?? '');

    if (p?.details != null) {
      initialTopics =
          p!.details.map((key, value) => MapEntry(key, value.toString()));
    }

    oldImages = List<String>.from(p!.images);
  }

  @override
  void dispose() {
    brandController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderAddView(
                  title: context.tr.editProduct,
                  icon: Icons.arrow_back_ios_new,
                ),
                const Divider(thickness: 1, color: ColorsBox.black),
                15.ph,
                CustomAddDetailsTitle(
                  title: widget.args!.product!.category.name,
                  icon: Icons.category,
                ),
                23.ph,
                // عرض/تعديل الصور
                CustomAddImage(
                  oldImages: oldImages,
                  onOldImageRemoved: (index) {
                    setState(() {
                      oldImages.removeAt(index);
                    });
                  },
                  onImagesSelected: (images) {
                    setState(() {
                      selectedImages = images;
                    });
                  },
                ),
                23.ph,
                CustomAddTextField(
                  title: context.tr.brand,
                  hint: context.tr.brandHint,
                  controller: brandController,
                ),
                23.ph,
                CustomAddTextField(
                  title: context.tr.adTitle,
                  hint: context.tr.enterTitle,
                  controller: titleController,
                ),
                23.ph,
                Text(
                  context.tr.describtion,
                  style: AppTextStyles.semiBold12()
                      .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                ),
                6.ph,
                CustomTextFormField(
                  hintText: context.tr.describtionHint,
                  height:
                      const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  controller: descriptionController,
                ),
                CustomEditTobic(
                  key: topicsKey,
                  initialTopics: initialTopics ?? {},
                ),

                23.ph,
                CustomAddTextField(
                  title: context.tr.location,
                  hint: context.tr.locationHint,
                  controller: locationController,
                ),
                23.ph,
                CustomAddTextField(
                  title: context.tr.price,
                  hint: context.tr.priceHint,
                  isPrice: true,
                  controller: priceController,
                ),
                7.ph,
                SizedBox(
                  width: double.infinity,
                  child: BlocListener<UpdateProductCubit, UpdateProductState>(
                    bloc: updateProductCubit,
                    listener: (context, state) {
                      if (state is UpdateProductSuccess) {
                        print('UpdateProductSuccess state received');
                        print('Local updated product: ${localUpdatedProduct?.title}');
                        print('Local updated product price: ${localUpdatedProduct?.price}');
                        print('State product: ${state.updatedProduct.title}');
                        print('State product price: ${state.updatedProduct.price}');
                        
                        // Prevent multiple navigation calls
                        if (_hasNavigated) {
                          print('Navigation already completed, skipping');
                          return;
                        }
                        
                        _hasNavigated = true;
                        
                        // Close any loading dialogs first
                        Navigator.of(context).pop();
                        
                        // Show success message
                        context.showSuccessSnackBar(
                            message: context.tr.update_success);
                        
                        // Navigate back to ProductDetailsView with updated data
                        print('About to navigate back to ProductDetailsView');
                        
                        // Ensure we use the local updated product, not the state product
                        final productToPass = localUpdatedProduct ?? state.updatedProduct;
                        print('Final product to pass: ${productToPass.title}');
                        print('Final product price: ${productToPass.price}');
                        
                        // Use GoRouter.pop() to return data properly
                        GoRouter.of(context).pop(productToPass);
                        
                        print('Navigation back to ProductDetailsView completed');
                      } else if (state is UpdateProductError) {
                        print('UpdateProductError state received');
                        // Close loading dialog
                        Navigator.of(context).pop();
                        context.showErrorSnackBar(
                            message: context.tr.update_error);
                      } else if (state is UpdateProductLoading) {
                        print('UpdateProductLoading state received');
                        context.showLoadingDialog();
                      }
                    },
                    child: CustomPrimaryButton(
                      title: context.tr.saveButton,
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          localUpdatedProduct = widget.args!.product!.copyWith(
                            slug: brandController.text,
                            title: titleController.text,
                            description: descriptionController.text,
                            location: locationController.text,
                            price: double.parse(priceController.text),
                            details:
                                topicsKey.currentState?.getTopicsMap() ?? {},
                            updatedAt: DateTime.now(),
                          );
                          print('Local updated product: ${localUpdatedProduct!.toJson()}');
                          await updateProductCubit.updateProduct(
                            localUpdatedProduct!,
                            selectedImages.isNotEmpty
                                ? selectedImages.first
                                : null,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
