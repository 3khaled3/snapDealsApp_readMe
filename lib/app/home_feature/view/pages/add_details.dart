import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_details_title.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_image.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_add_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_drop_down_button.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_tobic.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/create_product_cubit/create_product_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:uuid/uuid.dart';

class AddDetailsArgs {
  final Category? category;

  AddDetailsArgs(this.category,);
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
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderAddView(
                title: context.tr.adDetails,
                icon: Icons.arrow_back_ios_new,
              ),
              const Divider(thickness: 1, color: Colors.black),
              15.ph,
              CustomAddDetailsTitle(
                title: widget.args!.category!.name,
                icon: Icons.category,
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
                style: AppTextStyles.semiBold12().copyWith(
                    fontFamily: AppTextStyles.fontFamilyLora),
              ),
              6.ph,
              CustomTextFormField(
                hintText: context.tr.describtionHint,
                height: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                controller: descriptionController,
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
                child: BlocListener<CreateProductCubit, CreateProductState>(
                  listener: (context, state) {
                    if (state is CreateProductSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
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
                      if (formKey.currentState?.validate() ?? false) {
                        await BlocProvider.of<CreateProductCubit>(context)
                            .createProduct(
                          ProductModel(
                            id: const Uuid().v4(),
                            title: titleController.text,
                            user: Partner(
                              id: ProfileCubit.instance.state.profile.id,
                              name: ProfileCubit.instance.state.profile.name,
                              profileImg: ProfileCubit
                                  .instance.state.profile.profileImg,
                            ),
                            location: locationController.text,
                            slug: brandController.text,
                            description: descriptionController.text,
                            price: double.parse(priceController.text),
                            images: [],
                            category: Category(
                              id: widget.args!.category!.id,
                              name: widget.args!.category!.name,
                            ),
                            visit: 0,
                            details: topicsKey.currentState?.getTopicsMap() ?? {},
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
  );
}
}

// _AddMobileDetails(BuildContext context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       23.ph,
//       Text(
//         context.tr.ramWord,
//         style: AppTextStyles.semiBold12()
//             .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
//       ),
//       6.ph,
//       const CustomDropDownButton(index: 1),
//       23.ph,
//       Text(
//         context.tr.storageWord,
//         style: AppTextStyles.semiBold12()
//             .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
//       ),
//       6.ph,
//       const CustomDropDownButton(index: 2),
//       23.ph,
//       Text(
//         context.tr.batteryCapacityWord,
//         style: AppTextStyles.semiBold12()
//             .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
//       ),
//       6.ph,
//       const CustomDropDownButton(index: 3),
//     ],
//   );
// }
