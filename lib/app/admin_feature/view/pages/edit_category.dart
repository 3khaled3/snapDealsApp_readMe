import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/category_card.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/validators.dart';

class EditCategoryArgs {

}

class EditCategory extends StatelessWidget {
  const EditCategory({super.key, this.args});
  final EditCategoryArgs? args;
  static const String routeName = "/edit_category";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditCategoryCubit()..getAllCategoryData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Category",
            style: AppTextStyles.bold24(),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: BlocBuilder<EditCategoryCubit, EditCategoryState>(
          builder: (context, state) {
            if (state is GetCategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCategoriesSuccess) {
              final categories = state.categories;
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Column(
                    children: [
                      CategoryCard(
                        categoryName: category.name,
                        categoryId: category.id!,
                        categoryIcon:
                            Icons.category, // أو حسب نوع الأيقونة عندك
                      ),
                      20.ph,
                    ],
                  );
                },
              );
            } else if (state is GetCategoriesError) {
              return const Center(child: Text("حدث خطأ أثناء تحميل البيانات."));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99999)),
          backgroundColor: const Color.fromARGB(255, 0, 69, 165),
          elevation: 6,
          child: const Icon(Icons.add, color: ColorsBox.white, size: 30),
          onPressed: () {
            showAddCategory(context);
          },
        ),
      ),
    );
  }
}
void showAddCategory(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();

  final cubit = BlocProvider.of<EditCategoryCubit>(context); 

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(55),
        topRight: Radius.circular(55),
      ),
    ),
    builder: (modalContext) {
      return BlocProvider.value( 
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
            listener: (context, state) {
              if (state is AddCategorySuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(context.tr.add_category_success)),
                );
                cubit.getAllCategoryData(); // ✅ إعادة تحميل البيانات
              } else if (state is AddCategoryError) {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(context.tr.add_category_error)),
                );
              }
            },
            builder: (context, state) {
              return Container(
                height: 230,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      23.ph,
                      Text(
                        context.tr.add_category,
                        style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
                      ),
                      25.ph,
                      CustomTextFormField(
                        hintText: context.tr.add_category_hint,
                        labelText: context.tr.add_category_hint,
                        controller: categoryNameController,
                        validator: Validators.validateCategoryName,
                      ),
                      25.ph,
                      state is AddCategoryLoading
                          ? const CircularProgressIndicator()
                          : CustomButtonRow(
                              saveButtonText: context.tr.saveButton,
                              onSave: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  final name = categoryNameController.text;
                                  await cubit.addCategory(name);
                                }
                              },
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
