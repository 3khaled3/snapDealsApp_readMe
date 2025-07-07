import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/home_feature/view/widgets/chat_wrapper.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_courses_builder.dart';
import 'package:snap_deals/app/product_feature/view/pages/my_products&courses/my_products_builder.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

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
  late List<String> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabs = [
      Tr.current.products,
      Tr.current.courses,
    ];
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
            CustomAppBar(
              title: '${context.tr.my_products} & ${context.tr.my_courses}',
            ),
            10.ph,
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColorsBox.mainColor,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: ColorsBox.white,
              unselectedLabelColor: ColorsBox.mainColor,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashBorderRadius: BorderRadius.circular(100),
              dividerColor: Colors.transparent,
              tabs: _tabs.map((title) => TabChild(title: title)).toList(),
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
