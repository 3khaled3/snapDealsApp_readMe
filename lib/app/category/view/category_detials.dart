import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/category/view/all_courses_builder.dart';
import 'package:snap_deals/app/category/view/all_products_builder.dart';
import 'package:snap_deals/app/category/view/products.dart';
import 'package:snap_deals/app/home_feature/view/widgets/category_tab.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class CategoryDetailsArgs {
  final String title;
  final String? id;

  CategoryDetailsArgs({required this.id, required this.title});
}

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.args});
  final CategoryDetailsArgs args;

  static String route = "/CategoryDetails";

  @override
  createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Category> allCategories = [];
  int initialIndex = 0;
  @override
  void initState() {
    super.initState();

    allCategories = [
      Category(id: "6802df7227ad6e735473af04", name: "Engineering Tools"),
      Category(id: "6802df4d27ad6e735473af01", name: "Drowing Tools"),
      Category(id: "6802df4027ad6e735473aefe", name: "Electronic"),
      Category(id: "6802df1b27ad6e735473aefb", name: "Mobiles and Tablets"),
      Category(id: "6802df0a27ad6e735473aef8", name: "Courses"),
    ];

    // Determine the initial tab index
    if (widget.args.id == null || widget.args.title.toLowerCase() == "all") {
      initialIndex = 0; // Select 'All' tab
    } else {
      final categoryIndex =
          allCategories.indexWhere((cat) => cat.id == widget.args.id);
      initialIndex = categoryIndex != -1 ? categoryIndex + 1 : 0;
    }

    _tabController = TabController(
      length: allCategories.length + 1,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "Categories"),
            10.ph,
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    indicatorPadding: const EdgeInsets.all(0),
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    splashBorderRadius: BorderRadius.circular(100),
                    indicator: const BoxDecoration(),
                    tabs: [
                      CategoryTabChild(
                        title: context.tr.all,
                        isSelected: _tabController.index == 0,
                      ),
                      ...allCategories.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final category = entry.value;
                        return CategoryTabChild(
                          title: category.name,
                          isSelected: _tabController.index == index,
                        );
                      }).toList(),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        const AllProductList(),
                        ...allCategories.map((category) {
                          if (category.id == "6802df0a27ad6e735473aef8") {
                            return const AllCoursesList();
                          }
                          return ProductsByCategoryList(
                            id: category.id ?? "",
                          );
                        }).toList(),
                      ],
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
}
