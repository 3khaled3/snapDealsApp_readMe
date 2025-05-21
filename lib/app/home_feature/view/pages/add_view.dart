import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_course_details.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_details.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});
  static const String routeName = '/add_details_route';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditCategoryCubit()..getAllCategoryData(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: context.tr.addTitle),
              Expanded(
                child: BlocBuilder<EditCategoryCubit, EditCategoryState>(
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
                              CustomListTile(
                                title: category.name,
                                onTap: () {
                                  if (category.name == "Courses") {
                                    GoRouter.of(context).push(
                                        AddCourseDetails.routeName,
                                        extra: AddCourseDetailsArgs(category));
                                  } else {
                                    GoRouter.of(context).push(
                                        AddDetailsView.routeName,
                                        extra: AddDetailsArgs(category));
                                  }
                                },
                                leadingIcon: Icons.category,
                                // isAddView: true,
                              ),
                              15.ph,
                            ],
                          );
                        },
                      );
                    } else if (state is GetCategoriesError) {
                      return Center(child: Text(context.tr.error_loading_data));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
