import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/profile.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/favorite_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/app/home_feature/view/widgets/chat_wrapper.dart';
import 'package:snap_deals/app/home_feature/view/widgets/login_dialog.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
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
  final List<Widget> _views = [
    const HomeView(),
    ChatWrapper(),
    FavoriteView(),
    ProfileView(),
  ];
  @override
  void initState() {
    super.initState();
    if (ProfileCubit.instance.state.profile.role == Role.unregistered) {
      customAppDialog(
          context: context,
          title: Tr.current.login_prompt,
          supTitle: Tr.current.login_message,
          buttonTitle: Tr.current.login,
          cancelButtonTitle: Tr.current.continue_as_guest,
          onPressed: () {
            GoRouter.of(context)
                .push(LoginScreen.routeName, extra: LoginViewArgs());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('MainHomeView build called with index: $_currentIndex');
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,

      backgroundColor: Color(0xffF9FAFB),
      body: SafeArea(
        // child: _views[_currentIndex],
        child: IndexedStack(
          index: _currentIndex,
          children: _views,
        ),
      ),
      floatingActionButton: _buildBottomAppBar(),
      // bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBottomAppBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 10.pw,
            _buildAnimatedTab(
              icon: Icons.home,
              isSelected: _currentIndex == 0,
              onTap: () => _onTabTapped(0),
            ),
            _buildAnimatedTab(
              icon: Icons.chat,
              isSelected: _currentIndex == 1,
              onTap: () => _onTabTapped(1),
            ),
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999)),
              backgroundColor: const Color.fromARGB(255, 0, 69, 165),
              elevation: 8,
              child: const Icon(Icons.add, color: ColorsBox.white, size: 30),
              onPressed: () {
                if (ProfileCubit.instance.state.profile.role ==
                    Role.unregistered) {
                  GoRouter.of(context)
                      .push(LoginScreen.routeName, extra: LoginViewArgs());
                  return;
                }
                context.push(AddView.routeName);
              },
            ),
            _buildAnimatedTab(
              icon: EvaIcons.heart,
              isSelected: _currentIndex == 2,
              onTap: () => _onTabTapped(2),
            ),
            _buildAnimatedTab(
              icon: Icons.person,
              isSelected: _currentIndex == 3,
              onTap: () => _onTabTapped(3),
            ),
            // 10.pw,
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    if (index != 0 && index != 3 &&
        ProfileCubit.instance.state.profile.role == Role.unregistered) {
      GoRouter.of(context).push(LoginScreen.routeName, extra: LoginViewArgs());
      return;
    }
    setState(() => _currentIndex = index);
  }

  Widget _buildAnimatedTab(
      {required IconData icon,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsBox.brightBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: isSelected ? 1.2 : 1.0,
          child: Icon(
            icon,
            color: isSelected ? ColorsBox.brightBlue : ColorsBox.grey,
            size: 28,
          ),
        ),
      ),
    );
  }
}
