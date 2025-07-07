import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/search_feature/view/widget/search_product_builder.dart';
import 'package:snap_deals/app/search_feature/view/widget/search_text_failed.dart';
import 'package:snap_deals/app/search_feature/view_model/cubit/search_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class SearchViewArgs {
  SearchViewArgs();
}

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.args});
  final SearchViewArgs args;

  static String route = "/SearchView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const _SearchViewContent(),
    );
  }
}

class _SearchViewContent extends StatelessWidget {
  const _SearchViewContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: context.tr.search),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DebouncedSearchTextField(
                onSearchChanged: (value) {
                  cubit.searchProduct(value);
                },
              ),
            ),
            10.ph,
            const Expanded(
              child: SearchProductBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
