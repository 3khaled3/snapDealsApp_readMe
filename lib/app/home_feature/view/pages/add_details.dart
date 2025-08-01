import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_details_title.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_image.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_tobic.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/create_product_cubit/create_product_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:uuid/uuid.dart';

class AddDetailsArgs {
  final String id;
  final String name;
  final IconData icon;

  AddDetailsArgs(this.id, this.name, this.icon);
}

class AddDetailsView extends StatefulWidget {
  const AddDetailsView({
    super.key,
    this.args,
  });
  static const String routeName = '/add_route';
  final AddDetailsArgs? args;

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {
  final GlobalKey<CustomTobicState> topicsKey = GlobalKey<CustomTobicState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Category? category;

  @override
  void dispose() {
    brandController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    super.dispose();
  }

// أضف هذا في أعلى الكلاس
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.adDetails),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAddDetailsTitle(
                          title: widget.args!.name,
                          icon: widget.args!.icon,
                        ),
                        23.ph,

                        // 📸 استخدام CustomAddImage مع callback
                        CustomAddImage(
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
                              .copyWith(fontFamily: context.tr.fontFamilyLora),
                        ),
                        6.ph,
                        CustomTextFormField(
                          hintText: context.tr.describtionHint,
                          height: const EdgeInsets.only(
                              bottom: 100, left: 10, right: 10),
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.tr.text_field_enter_req;
                            }
                            return null;
                          },
                        ),
                        CustomTobic(key: topicsKey),
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

                        // زر الإرسال
                        SizedBox(
                          width: double.infinity,
                          child: BlocListener<CreateProductCubit,
                              CreateProductState>(
                            listener: (context, state) {
                              if (state is CreateProductSuccess) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  context.showSuccessSnackBar(
                                      message: context.tr.add_product_success);
                                  GoRouter.of(context).pushReplacement(
                                      MainHomeView.routeName,
                                      extra: MainHomeViewArgs());
                                });
                              } else if (state is CreateProductError) {
                                context.showErrorSnackBar(
                                    message: context.tr.add_product_error);
                                Navigator.of(context).pop();
                              } else if (state is CreateProductLoading) {
                                context.showLoadingDialog();
                              }
                            },
                            child: CustomPrimaryButton(
                              title: context.tr.nextButton,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  if (selectedImages.isEmpty) {
                                    context.showErrorSnackBar(
                                        message:
                                            context.tr.Please_select_an_image);
                                  }
                                  await BlocProvider.of<CreateProductCubit>(
                                          context)
                                      .createProduct(
                                    ProductModel(
                                      id: const Uuid().v4(),
                                      title: titleController.text,
                                      user: Partner(
                                        id: ProfileCubit
                                            .instance.state.profile.id,
                                        name: ProfileCubit
                                            .instance.state.profile.name,
                                        profileImg: ProfileCubit
                                            .instance.state.profile.profileImg,
                                        role: ProfileCubit
                                            .instance.state.profile.role,
                                        notificationToken: ProfileCubit.instance
                                            .state.profile.notificationToken,
                                      ),
                                      location: locationController.text,
                                      slug: brandController.text,
                                      description: descriptionController.text,
                                      price: double.parse(priceController.text),
                                      images: [],
                                      category: Category(
                                        id: widget.args!.id,
                                        name: widget.args!.name,
                                      ),
                                      visit: 0,
                                      details: topicsKey.currentState
                                              ?.getTopicsMap() ??
                                          {},
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    ),
                                    selectedImages.isNotEmpty
                                        ? selectedImages.first
                                        : XFile(''),
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
            ),
          ],
        ),
      ),
    );
  }
}
