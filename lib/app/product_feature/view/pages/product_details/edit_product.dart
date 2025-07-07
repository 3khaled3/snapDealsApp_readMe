import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/update_product_cubit/update_product_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_edit_topic.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

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
  final GlobalKey<CustomEditTobicState> topicsKey =
      GlobalKey<CustomEditTobicState>();

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
                // CustomAddDetailsTitle(
                //   title: widget.args!.product!.category.name,
                //   icon: Icons.category,
                // ),
                // 23.ph,

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
                  initialTopics: initialTopics,
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
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.showSuccessSnackBar(
                              message: context.tr.update_success);
                          GoRouter.of(context).pushReplacement(
                              MainHomeView.routeName); // العودة للصفحة السابقة
                        });
                      } else if (state is UpdateProductError) {
                        context.showErrorSnackBar(
                            message: context.tr.update_error);
                      } else if (state is UpdateProductLoading) {
                        context.showLoadingDialog();
                      }
                    },
                    child: CustomPrimaryButton(
                      title: context.tr.saveButton,
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final updatedProduct = widget.args!.product!.copyWith(
                            slug: brandController.text,
                            title: titleController.text,
                            description: descriptionController.text,
                            location: locationController.text,
                            price: double.parse(priceController.text),
                            details:
                                topicsKey.currentState?.getTopicsMap() ?? {},
                            updatedAt: DateTime.now(),
                          );
                          final Map<String, dynamic> updatedFields = {};

                          if (updatedProduct.slug !=
                              widget.args!.product!.slug) {
                            updatedFields['slug'] = updatedProduct.slug;
                          }
                          if (updatedProduct.title !=
                              widget.args!.product!.title) {
                            updatedFields['title'] = updatedProduct.title;
                          }
                          if (updatedProduct.description !=
                              widget.args!.product!.description) {
                            updatedFields['description'] =
                                updatedProduct.description;
                          }
                          if (updatedProduct.location !=
                              widget.args!.product!.location) {
                            updatedFields['location'] = updatedProduct.location;
                          }
                          if (updatedProduct.price !=
                              widget.args!.product!.price) {
                            updatedFields['price'] = updatedProduct.price;
                          }
                          if (updatedProduct.details.toString() !=
                              widget.args!.product!.details.toString()) {
                            updatedFields['details'] = updatedProduct.details;
                          }
                          if (selectedImages.isNotEmpty) {
                            updatedFields['newImages'] =
                                selectedImages; // لو فيه صور جديدة
                          }
                          if (oldImages.length !=
                              widget.args!.product!.images.length) {
                            updatedFields['oldImages'] = oldImages;
                          }
                          print(
                              'Topics Map: ${topicsKey.currentState?.getTopicsMap()}');

                          await updateProductCubit.updateProduct(
                              updatedProduct, updatedFields);
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
