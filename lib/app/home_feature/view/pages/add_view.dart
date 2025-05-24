import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_course_details.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_details.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_header_add_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});
  static const String routeName = '/add_details_route';

  final List<Map<String, dynamic>> categories = const [
    {
      'id': '6802df0a27ad6e735473aef8',
      'nameKey': 'courses',
      'icon': Icons.school_outlined,
    },
    {
      'id': '6802df1b27ad6e735473aefb',
      'nameKey': 'mobilesAndTablets',
      'icon': Icons.phone_iphone_outlined,
    },
    {
      'id': '6802df4d27ad6e735473af01',
      'nameKey': 'drawingTools',
      'icon': Icons.draw_outlined,
    },
    {
      'id': '6802df7227ad6e735473af04',
      'nameKey': 'engineeringTools',
      'icon': Icons.engineering_outlined,
    },
    {
      'id': '6802df4027ad6e735473aefe',
      'nameKey': 'electronics',
      'icon': Icons.computer_outlined,
    },
    {
      'id': '',
      'nameKey': 'other',
      'icon': Icons.category_outlined,
    },
  ];

  String translateCategoryName(BuildContext context, String key) {
    final tr = context.tr;
    switch (key) {
      case 'courses':
        return tr.courses;
      case 'mobilesAndTablets':
        return tr.mobilesAndTablets;
      case 'drawingTools':
        return tr.drawingTools;
      case 'engineeringTools':
        return tr.engineeringTools;
      case 'electronics':
        return tr.electronics;
      case 'other':
        return tr.other;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
        child: Column(
          children: [
            CustomHeaderAddView(title: context.tr.addTitle, icon: Icons.close),
            const Divider(thickness: 1, color: Colors.black),
            ...categories.map((category) {
              final name = translateCategoryName(context, category['nameKey']);
              final icon = category['icon'] as IconData;
              final id = category['id'] as String;

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CustomListTile(
                  title: name,
                  leadingIcon: icon,
                  isAddView: true,
                  onTap: () {
                    if (id == '6802df0a27ad6e735473aef8') {
                      GoRouter.of(context).push(
                        AddCourseDetails.routeName,
                        extra: AddCourseDetailsArgs(id, name, icon),
                      );
                    } else {
                      GoRouter.of(context).push(
                        AddDetailsView.routeName,
                        extra: AddDetailsArgs(id, name, icon),
                      );
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:snap_deals/app/admin_feature/model_view/edit_category_cubit/edit_category_cubit.dart';
// import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
// import 'package:snap_deals/app/auth_feature/view/widgets/custom_list_tile.dart';
// import 'package:snap_deals/app/home_feature/view/pages/add_course_details.dart';
// import 'package:snap_deals/app/home_feature/view/pages/add_details.dart';
// import 'package:snap_deals/core/extensions/context_extension.dart';
// import 'package:snap_deals/core/extensions/sized_box_extension.dart';

// class AddView extends StatelessWidget {
//   const AddView({super.key});
//   static const String routeName = '/add_details_route';
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EditCategoryCubit()..getAllCategoryData(),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               CustomAppBar(title: context.tr.addTitle),
//               Expanded(
//                 child: BlocBuilder<EditCategoryCubit, EditCategoryState>(
//                   builder: (context, state) {
//                     if (state is GetCategoriesLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is GetCategoriesSuccess) {
//                       final categories = state.categories;
//                       return ListView.builder(
//                         padding: const EdgeInsets.all(16.0),
//                         itemCount: categories.length,
//                         itemBuilder: (context, index) {
//                           final category = categories[index];
//                           return Column(
//                             children: [
//                               CustomListTile(
//                                 title: category.name,
//                                 onTap: () {
//                                   if (category.name == "Courses") {
//                                     GoRouter.of(context).push(
//                                         AddCourseDetails.routeName,
//                                         extra: AddCourseDetailsArgs(category));
//                                   } else {
//                                     GoRouter.of(context).push(
//                                         AddDetailsView.routeName,
//                                         extra: AddDetailsArgs(category));
//                                   }
//                                 },
//                                 leadingIcon: Icons.category,
//                                 // isAddView: true,
//                               ),
//                               15.ph,
//                             ],
//                           );
//                         },
//                       );
//                     } else if (state is GetCategoriesError) {
//                       return Center(child: Text(context.tr.error_loading_data));
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
