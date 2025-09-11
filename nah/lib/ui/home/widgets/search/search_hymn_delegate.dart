import 'package:flutter/material.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';
import 'package:nah/ui/home/widgets/search/filtered_hymn_list.dart';

/// [SearchHymnDelegate] manages the data displayed in the search page
class SearchHymnDelegate extends SearchDelegate {
  ///property to hold the current index based on the search IconButton tapped in the HOMEAPPBAR.
  ///Will return true if the HOME FAB is clicked
  final bool searchingHymnId;
  final HomeViewModel homeViewModel;

  SearchHymnDelegate({
    super.searchFieldLabel,
    super.searchFieldStyle,
    super.searchFieldDecorationTheme,
    super.keyboardType,
    super.textInputAction,
    super.autocorrect,
    super.enableSuggestions,
    required this.searchingHymnId,
    required this.homeViewModel,
  });

  // Overrode the search bar label to display a custom one
  @override
  String? get searchFieldLabel =>
      'Search hymn ${searchingHymnId ? 'number' : 'title, lyrics'}';

  // Overrode the keyboardType to show a number keyborad if searchHymnId is true else, return a text keyboard
  @override
  TextInputType? get keyboardType => searchingHymnId
      ? TextInputType.numberWithOptions(signed: false, decimal: false)
      : TextInputType.text;

  // Overrode the actions to display the clear querry button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
        tooltip: 'Clear querry',
      ),
    ];
  }

  // Overrode the leading to display a back button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  // Hymns to be shown after submission of the querry
  @override
  Widget buildResults(BuildContext context) {
    return FilteredHymnList(
      query: query,
      searchingHymnId: searchingHymnId,
      homeViewModel: homeViewModel,
    );
  }

  // Hymns shown during entry of querry
  @override
  Widget buildSuggestions(BuildContext context) {
    return FilteredHymnList(
      query: query,
      searchingHymnId: searchingHymnId,
      homeViewModel: homeViewModel,
    );
  }
}
