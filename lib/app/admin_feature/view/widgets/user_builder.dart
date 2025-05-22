import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/shimmer_user_card.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/user_card.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class UserBuilder extends StatefulWidget {
  final AccessUserCubit accessUserCubit;

  const UserBuilder({super.key, required this.accessUserCubit});

  @override
  State<UserBuilder> createState() => _UserBuilderState();
}

class _UserBuilderState extends State<UserBuilder> {
  final ScrollController _scrollController = ScrollController();

  late AccessUserCubit accessUserCubit;

  int page = 1;
  final int limit = 5;
  bool _isLoading = false;
  bool _hasMore = true;
  List<UserModel> _users = [];

  @override
  void initState() {
    super.initState();
    accessUserCubit = widget.accessUserCubit;
    _loadInitialUsers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialUsers() {
    accessUserCubit.getAllUsersData(
        page: page.toString(), limit: limit.toString());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreUsers();
    }
  }

  void _loadMoreUsers() {
    setState(() => _isLoading = true);
    page++;
    accessUserCubit.getAllUsersData(
        page: page.toString(), limit: limit.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessUserCubit, AccessUserState>(
      bloc: accessUserCubit,
      listener: (context, state) {
        if (state is GetAllUsersSuccess) {
          _isLoading = false;
          if (page == 1) {
            _users = state.users;
          } else {
            _users.addAll(state.users);
          }
          if (state.users.length < limit) _hasMore = false;
        } else if (state is GetAllUsersError) {
          _isLoading = false;
          page--;
        }
      },
      builder: (context, state) {
        if (state is GetSpecificUserSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: [
                UserCard(uesrs: state.user),
                16.ph,
                TextButton(
                  onPressed: () {
                    page = 1;
                    _users.clear();
                    _hasMore = true;
                    _isLoading = false;
                    accessUserCubit.getAllUsersData(
                      page: page.toString(),
                      limit: limit.toString(),
                    );
                  },
                  child: Text(
                    context.tr.display_all_users,
                    style: AppTextStyles.semiBold14(),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is GetAllUsersLoading && page == 1) {
          return Column(
            children: List.generate(2, (index) => const ShimmerUserCard()),
          );
        } else if (state is GetAllUsersError && page == 1) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error loading users"),
                ElevatedButton(
                  onPressed: _loadInitialUsers,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ..._users.map((user) => UserCard(uesrs: user)),
                    if (_isLoading)
                      Column(
                        children:
                            List.generate(2, (_) => const ShimmerUserCard()),
                      ),
                    if (!_hasMore && _users.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(child: Text("No more users")),
                      ),
                  ],
                ),
              ),
              if (state is GetAllUsersError && page > 1)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _loadMoreUsers,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red.withOpacity(0.7),
                      child: const Text(
                        "Error loading more. Tap to retry",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
