import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/costum_list_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/products_header.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class CoursesViewArgs {
  final String title;

  CoursesViewArgs({required this.title});
}

class CoursesView extends StatelessWidget {
  const CoursesView({super.key, this.args});
  final CoursesViewArgs? args;
  static const String routeName = '/courses_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 60, left: 11, right: 11, bottom: 20),
        child: Column(
          children: [
            ProductsHeader(
              title: args!.title,
            ),
            17.ph,
            CustomTextFormField(
              hintText: context.tr.hintSearch,
              suffixIcon: Icons.search,
            ),
            20.ph,
            SizedBox(height: 600, width: double.infinity, child: CourseList())
          ],
        ),
      ),
    );
  }
}
