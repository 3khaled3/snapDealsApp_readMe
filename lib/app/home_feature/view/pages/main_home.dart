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
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: currentIndex == 1
          ? const HomeView()
          : currentIndex == 2
              ? const ChatView()
              : currentIndex == 3
                  ? const FavoriteView()
                  : currentIndex == 4
                      ? const ProfileView()
                      : const HomeView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsBox.brightBlue,
        child: const Center(
          child: Icon(
            Icons.add,
            size: 30,
            color: ColorsBox.white,
          ),
        ),
        onPressed: () {
          GoRouter.of(context).push(AddView.routeName);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        color: ColorsBox.brightBlue,
        child: SizedBox(
          height: 77,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 40,
                    color: ColorsBox.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                  icon: const Icon(
                    Icons.quickreply_outlined,
                    size: 40,
                    color: ColorsBox.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  icon: const Icon(
                    EvaIcons.heart,
                    size: 40,
                    color: ColorsBox.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 40,
                    color: ColorsBox.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
