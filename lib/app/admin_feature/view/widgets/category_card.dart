import 'package:flutter/material.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/custom_dialog.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.categoryName,
      required this.categoryId,
      this.categoryIcon});
  final String categoryName;
  final String categoryId;
  final IconData? categoryIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: ColorsBox.slateGrey, width: 1),
      ),
      leading: Icon(categoryIcon ?? Icons.category, size: 30),
      title: Text(
        categoryName,
        style: AppTextStyles.semiBold16(),
      ),
      subtitle: Text(
        categoryId,
        style: AppTextStyles.semiBold12(),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () =>
                  CustomDialog.deleteCategory(context, categoryId),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => CustomDialog.editCategory(
                  context, categoryId, categoryName),
            ),
          ],
        ),
      ),
    );
  }
}
