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
      floatingActionButton: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      // notchMargin: 10,
      color: Colors.transparent,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: ColorsBox.brightBlue,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: ColorsBox.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home),
            _buildNavItem(1, Icons.chat_outlined, Icons.chat),
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99999)),
              backgroundColor: const Color.fromARGB(255, 0, 69, 165),
              elevation: 6,
              child: const Icon(Icons.add, color: ColorsBox.white, size: 30),
              onPressed: () => context.push(AddView.routeName),
            ),
            _buildNavItem(2, EvaIcons.heartOutline, EvaIcons.heart),
            _buildNavItem(3, Icons.person_outline, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon) {
    final bool isActive = _currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(9999),
      splashColor: ColorsBox.white.withOpacity(0.2),
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isActive ? ColorsBox.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Icon(
          isActive ? filledIcon : outlineIcon,
          size: 28,
          color: ColorsBox.white.withOpacity(isActive ? 1 : 0.6),
        ),
      ),
    );
  }
}
