import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/profile.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_room_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_tickets_view.dart';
import 'package:snap_deals/app/chat_feature/view/pages/chat_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/add_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/favorite_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
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
    HomeView(),
    BlocProvider.value(
      value: ChatRoomCubit(),
      child: const ChatTicketsView(),
    ),
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
        child: _views[_currentIndex],
        // IndexedStack(
        //   index: _currentIndex,
        //   children:,
        // ),
      ),
      floatingActionButton: _buildBottomAppBar(),
      // bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBottomAppBar() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
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
        padding: const EdgeInsets.all(4),
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
      onTap: () {
        print('Tapped on index: $index');
        if (index != 0 &&
            ProfileCubit.instance.state.profile.role == Role.unregistered) {
          GoRouter.of(context)
              .push(LoginScreen.routeName, extra: LoginViewArgs());
          return;
        }
        setState(() {
          _currentIndex = index;
          print('Current index: $_currentIndex');
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
