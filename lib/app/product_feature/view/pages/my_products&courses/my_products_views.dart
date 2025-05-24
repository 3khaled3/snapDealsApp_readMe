import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_courses_builder.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_products_builder.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/app/home_feature/view/widgets/category_tab.dart'; // للتبويبات بنفس التصميم

class MyProductsViewsArgs {}

class MyProductsViews extends StatefulWidget {
  const MyProductsViews({super.key, this.args});

  static const routeName = '/my_products_views';
  final MyProductsViewsArgs? args;

  @override
  State<MyProductsViews> createState() => _MyProductsViewsState();
}

class _MyProductsViewsState extends State<MyProductsViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // لتحديث التبويبات عند التغيير
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tabs.isEmpty) {
      tabs.addAll([context.tr.products, context.tr.courses]);
    }
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
            CustomAppBar(title: '${context.tr.my_products} & ${context.tr.my_courses}'),
            10.ph,
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              indicatorPadding: const EdgeInsets.all(0),
              padding: const EdgeInsetsDirectional.only(start: 8),
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              splashBorderRadius: BorderRadius.circular(100),
              indicator: const BoxDecoration(),
              tabs: tabs.asMap().entries.map((entry) {
                final index = entry.key;
                return CategoryTabChild(
                  title: entry.value,
                  isSelected: _tabController.index == index,
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  MyProductsBuilder(),
                  MyCoursesBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
