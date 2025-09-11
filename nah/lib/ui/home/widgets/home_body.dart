import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/sliver_hymn_list.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';
import 'package:nah/ui/home/widgets/home_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.homeViewModel});
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      key: ValueKey("HOMEBODY_LISTENABLE_BUILDER"),
      listenable: homeViewModel.load,
      builder: (context, child) {
        return CustomScrollView(
          // controller: _scrollController,
          slivers: [
            HomeAppBar(homeViewModel: homeViewModel),
            SliverHymnList(
              key: ValueKey("HOME_SCREEN_HYMN_LIST"),
              hymns: homeViewModel.hymns,
            ),
          ],
        );
      },
    );
  }
}
