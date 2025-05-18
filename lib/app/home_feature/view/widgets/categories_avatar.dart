import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/pages/edit_category.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/home_feature/view/pages/courses.dart';
import 'package:snap_deals/app/home_feature/view/pages/products.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
class CategoriesAvatar extends StatefulWidget {
  const CategoriesAvatar({super.key});

  @override
  State<CategoriesAvatar> createState() => _CategoriesAvatarState();
}

class _CategoriesAvatarState extends State<CategoriesAvatar> {
  bool isMore = false;
  final EditCategoryCubit editCategoryCubit = EditCategoryCubit();

  // أيقونات ثابتة حسب اسم التصنيف
  final Map<String, IconData> categoryIcons = {
    Tr.current.medicalTools: Icons.medical_services_outlined,
    Tr.current.courses: Icons.school_outlined,
    Tr.current.mobilesAndTablets: Icons.phone_iphone_outlined,
    Tr.current.drawingTools: Icons.school_outlined,
    Tr.current.engineeringTools: Icons.engineering_outlined,
    Tr.current.electronics: Icons.computer_outlined,
    Tr.current.more: Icons.expand_more,
    Tr.current.less: Icons.expand_less,
  };
  

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        editCategoryCubit.getAllCategoryData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryCubit, EditCategoryState>(
      bloc: editCategoryCubit,
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCategoriesError) {
          return Center(child: Text("Something went wrong"));
        } else if (state is GetCategoriesSuccess) {
          final allCategories = state.categories;
          final List<String> categoryNames =
              allCategories.map((c) => c.name).toList();

          final displayNames = isMore
              ? [...categoryNames, context.tr.less]
              : [...categoryNames.take(3), context.tr.more];

          return Wrap(
            runSpacing: 20,
            spacing: 15,
            children: List.generate(displayNames.length, (index) {
              final name = displayNames[index];
              final icon = categoryIcons[name] ?? Icons.category;

              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final user = ProfileCubit.instance.state.profile;
                        final isAdmin = user.role == Role.admin;

                        if (name == context.tr.more) {
                          if (isAdmin) {
                            GoRouter.of(context).push(
                              EditCategory.routeName,
                              extra: EditCategoryArgs(),
                            );
                          } else {
                            setState(() => isMore = true);
                          }
                        } else if (name == context.tr.less) {
                          setState(() => isMore = false);
                        } else if (name == context.tr.courses) {
                          GoRouter.of(context).push(
                            CoursesView.routeName,
                            extra: CoursesViewArgs(title: name),
                          );
                        } else {
                          GoRouter.of(context).push(
                            ProductsView.routeName,
                            extra: ProductsViewArgs(title: name,id: allCategories[index].id),
                          );
                        }
                      },
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: ColorsBox.paleGrey,
                          child: Icon(
                            icon,
                            color: ColorsBox.brightBlue,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular16(),
                    ),
                  ],
                ),
              );
            }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
