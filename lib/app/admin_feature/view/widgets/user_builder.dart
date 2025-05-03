import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/admin_feature/model_view/access_user_cubit/access_user_cubit.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/shimmer_user_card.dart';
import 'package:snap_deals/app/admin_feature/view/widgets/user_card.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';

class UserBuilder extends StatefulWidget {
  const UserBuilder({super.key});

  @override
  State<UserBuilder> createState() => _UserBuilderState();
}

class _UserBuilderState extends State<UserBuilder> {
  final ScrollController _scrollController = ScrollController();
  final AccessUserCubit accessUserCubit = AccessUserCubit();

  int page = 1;
  final int limit = 5;
  bool _isLoading = false;
  bool _hasMore = true;
  List<UserModel> _users = [];

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialProducts() {
    accessUserCubit.getAllUsersData(
      page: page.toString(),
      limit: limit.toString(),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    setState(() => _isLoading = true);
    page++;
    accessUserCubit.getAllUsersData(
      page: page.toString(),
      limit: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: BlocConsumer<AccessUserCubit, AccessUserState>(
        bloc: accessUserCubit,
        listener: (context, state) {
          if (state is GetAllUsersSuccess) {
            _isLoading = false;

            if (page == 1) {
              _users = state.users;
            } else {
              _users.addAll(state.users);
            }

            if (state.users.length < limit) {
              _hasMore = false;
            }
          } else if (state is GetAllUsersError) {
            _isLoading = false;
            page--;
          }
        },
        builder: (context, state) {
  // ✅ عرض المستخدم المحدد فقط إذا تم البحث بالـ ID
  if (state is GetSpecificUserSuccess) {
    final user = state.user;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
         UserCard(uesrs: user),
          const SizedBox(height: 16),
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
            child: const Text("عرض جميع المستخدمين"),
          ),
        ],
      ),
    );
  }

  // 👇 باقي الحالات كما هي (قائمة المستخدمين، shimmer، إلخ)
  if (state is GetAllUsersLoading && page == 1) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        children: List.generate(5, (index) => const ShimmerUserCard()),
      ),
    );
  } else if (state is GetAllUsersError && page == 1) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error loading products"),
          ElevatedButton(
            onPressed: _loadInitialProducts,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  } else {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          child: Row(
            children: [
              ..._users.map(
                (user) => UserCard(uesrs: user)
              ),
              if (_isLoading)
                Row(
                  children:
                      List.generate(5, (index) => const ShimmerProductCard()),
                ),
              if (!_hasMore && _users.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
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
              onTap: _loadMoreProducts,
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
}
),
    );
  }
}
