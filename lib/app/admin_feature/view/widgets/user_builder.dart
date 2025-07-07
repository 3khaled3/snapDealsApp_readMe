import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/shimmer_user_card.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/user_card.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class UserBuilder extends StatefulWidget {
  const UserBuilder({super.key});

  @override
  State<UserBuilder> createState() => _UserBuilderState();
}

class _UserBuilderState extends State<UserBuilder> {
  final PagingController<int, UserModel> _pagingController =
      PagingController(firstPageKey: 1);

  late final AccessUserCubit _accessUserCubit;

  final int limit = 5;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _accessUserCubit = BlocProvider.of<AccessUserCubit>(context);

    _pagingController.addPageRequestListener((pageKey) {
      _currentPage = pageKey;
      _accessUserCubit.getAllUsersData(
        page: pageKey.toString(),
        limit: limit.toString(),
      );
    });
  }

  void _handleUsers(List<UserModel> users) {
    final isLastPage = users.length < limit;

    if (_currentPage == 1) {
      _pagingController.itemList = [];
    }

    if (isLastPage) {
      _pagingController.appendLastPage(users);
    } else {
      _pagingController.appendPage(users, _currentPage + 1);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccessUserCubit, AccessUserState>(
      bloc: _accessUserCubit,
      listener: (context, state) {
        if (state is GetAllUsersSuccess) {
          _handleUsers(state.users);
        } else if (state is GetAllUsersError) {
          _pagingController.error = context.tr.error_user_loag;
        } else if (state is DeleteUserSuccess) {
          _pagingController.refresh();
        }
      },
      child: PagedListView<int, UserModel>(
        pagingController: _pagingController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        builderDelegate: PagedChildBuilderDelegate<UserModel>(
          itemBuilder: (context, user, index) => UserCard(uesrs: user),
          firstPageProgressIndicatorBuilder: (_) => Column(
            children: List.generate(2, (_) => const ShimmerUserCard()),
          ),
          newPageProgressIndicatorBuilder: (_) => Column(
            children: List.generate(1, (_) => const ShimmerUserCard()),
          ),
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr.error_user_loag,
                  style: AppTextStyles.semiBold16()
                      .copyWith(color: ColorsBox.black),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _pagingController.refresh(),
                  child: Text(
                    context.tr.retry,
                    style: AppTextStyles.semiBold16()
                        .copyWith(color: ColorsBox.brightBlue),
                  ),
                ),
              ],
            ),
          ),
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: Text(
              context.tr.no_more_user,
              style: AppTextStyles.medium14(),
            ),
          ),
        ),
      ),
    );
  }
}
