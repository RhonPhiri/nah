import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/sliver_hymn_list.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';

class FilteredHymnList extends StatelessWidget {
  const FilteredHymnList({
    super.key,
    required this.query,
    required this.searchingHymnId,
    required this.homeViewModel,
  });
  final String query;
  final bool searchingHymnId;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final filteredHymns = homeViewModel.filterHymnList(query, searchingHymnId);

    // Show an empty hymns widget if none of the hymns match the querry
    return filteredHymns.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('No Hymns found', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 8),
              // NoData(gender: "female"),
            ],
          )
        : CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverHymnList(hymns: filteredHymns),
            ],
          );
  }
}
