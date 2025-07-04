import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_bottom_sheet.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/validators.dart';

abstract class CustomDialog {
  static void editCategory(
      BuildContext context, String categoryId, String currentName) {
    final TextEditingController editingController =
        TextEditingController(text: currentName);
    final formKey = GlobalKey<FormState>();

    final cubit =
        BlocProvider.of<EditCategoryCubit>(context); // ✅ خذ نفس الCubit

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit, // ✅ نمرر نفس الCubit الموجود حاليًا
        child: AlertDialog(
          title: Text(context.tr.update_category),
          content: SizedBox(
            width: 400,
            child: Form(
              key: formKey,
              child: CustomTextFormField(
                hintText: context.tr.update_category_hint,
                labelText: context.tr.update_category,
                controller: editingController,
                validator: Validators.validateCategoryName,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomBottomSheet.buildButton(
                      text: context.tr.cancelWord,
                      textColor: ColorsBox.brightBlue,
                      borderColor: ColorsBox.brightBlue,
                      onTap: () => Navigator.pop(
                          dialogContext), // استخدم dialogContext هنا
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: CustomBottomSheet.buildButton(
                      text: context.tr.saveButton,
                      textColor: ColorsBox.white,
                      backgroundColor: ColorsBox.brightBlue,
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final name = editingController.text.trim();
                          await cubit.updateCategory(categoryId, name);
                          cubit.getAllCategoryData();
                          Navigator.pop(dialogContext);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void deleteCategory(BuildContext context, String categoryId) {
    final cubit =
        BlocProvider.of<EditCategoryCubit>(context); // ✅ خد نفس الCubit

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text(context.tr.delete_category),
          content: Text(context.tr.delete_category_hint),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.tr.cancelWord),
            ),
            TextButton(
              onPressed: () async {
                await cubit.deleteCategory(categoryId);
                cubit.getAllCategoryData();
                Navigator.pop(dialogContext);
              },
              child: Text(
                context.tr.deleteWord,
               style: AppTextStyles.semiBold16().copyWith(color: ColorsBox.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void deleteUser(BuildContext context, String userId) {
  final cubit = BlocProvider.of<AccessUserCubit>(context);

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<AccessUserCubit, AccessUserState>(
          listener: (context, state) {
            debugPrint('AccessUserCubit state changed: $state');

            if (state is DeleteUserLoading) {
              // ✅ افتح Dialog تحميل
              context.showLoadingDialog();
            }

            else if (state is DeleteUserSuccess) {
              debugPrint('🎯 DeleteUserSuccess caught, refreshing list');
              // ✅ اقفل Dialog التحميل
              Navigator.of(context, rootNavigator: true).pop(); 
              // ✅ اقفل Dialog التأكيد
              Navigator.pop(dialogContext); 

              cubit.getAllUsersData(page: '1', limit: '5');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.tr.deleteAccountSuccess)),
              );
            }

            else if (state is DeleteUserError) {
              // ✅ اقفل Dialog التحميل فقط (التأكيد لسه مفتوح)
              Navigator.of(context, rootNavigator: true).pop(); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.tr.deleteAccountError)),
              );
            }
          },
          child: AlertDialog(
            backgroundColor: ColorsBox.white,
            title: Text(context.tr.deleteUser),
            content: Text(context.tr.deleteUserHint),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  context.tr.cancelWord,
                  style: AppTextStyles.semiBold16().copyWith(color: ColorsBox.black),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await cubit.deleteUser(userId);
                },
                child: Text(
                  context.tr.deleteWord,
                  style: AppTextStyles.semiBold16().copyWith(color: ColorsBox.red),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
