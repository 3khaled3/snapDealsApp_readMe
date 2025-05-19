import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_bottom_sheet.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
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
                  const SizedBox(width: 10),
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
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void deleteUser(BuildContext context, String userId) {
    final cubit = BlocProvider.of<AccessUserCubit>(context); // ✅ خد نفس الCubit

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text(context.tr.deleteUser),
          content: Text(context.tr.deleteUserHint),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.tr.cancelWord),
            ),
            TextButton(
              onPressed: () async {
                await cubit.deleteUser(userId);
                cubit.getAllUsersData(limit: 5.toString(), page: 1.toString());
                Navigator.pop(dialogContext);
              },
              child: Text(
                context.tr.deleteWord,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
