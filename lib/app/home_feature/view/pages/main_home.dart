import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/profile.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/favorite_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

class MainHomeViewArgs {}

class MainHomeView extends StatefulWidget {
  const MainHomeView(this.args, {super.key});
  final MainHomeViewArgs? args;
  static const String routeName = '/main_home_route';

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int _currentIndex = 0;
  final List<Widget> _views = const [
    HomeView(),
    ChatView(),
    FavoriteView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _views,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsBox.brightBlue,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () => context.push(AddView.routeName),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 12,
      color: ColorsBox.brightBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home),
            _buildNavItem(1, Icons.chat_outlined, Icons.chat),
            const SizedBox(width: 50),
            _buildNavItem(2, EvaIcons.heartOutline, EvaIcons.heart),
            _buildNavItem(3, Icons.person_outline, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon) {
    return IconButton(
      icon: Icon(
        _currentIndex == index ? filledIcon : outlineIcon,
        size: 40,
        color: _currentIndex == index
            ? ColorsBox.white
            : ColorsBox.white.withOpacity(0.6),
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}
