import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nah/ui/core/ui/core_ui_export.dart';
import 'package:nah/ui/hymn/widgets/drawer/nah_drawer.dart';
import 'package:nah/ui/hymn/widgets/search/search_hymn_delegate.dart';
import 'package:nah/ui/hymnal/view_model/hymnal_provider.dart';
import 'package:nah/ui/hymn/view_model/hymn_provider.dart';
import 'package:nah/ui/hymnal/widgets/hymnal_screen.dart';
import 'package:provider/provider.dart';

/// Main screen for displaying hymns and searching/selecting hymnals.

///Enum to hold the trailing action buttons of the hymnScreen appBar
enum ActionButtons {
  search,
  hymnal;

  IconData get icon {
    switch (this) {
      case ActionButtons.search:
        return Icons.search;
      case ActionButtons.hymnal:
        return Icons.book;
    }
  }

  void onPressed(BuildContext context) {
    switch (this) {
      case ActionButtons.search:
        showSearch(
          context: context,
          delegate: SearchHymnDelegate(searchingHymnId: false),
        );
      case ActionButtons.hymnal:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => HymnalScreen()));
    }
  }
}

class HymnScreen extends StatefulWidget {
  const HymnScreen({super.key});

  @override
  State<HymnScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends State<HymnScreen> {
  //Variable to hold the current scrolling status
  bool _isScrollingDown = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    //Delay the call to loadHymnals() until after the widget tree is built.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<HymnalProvider>().loadHymnals();

      // If the widget is mounted in the widget tree, run the following callbacks.
      if (!mounted) return;
      // After hymnals are loaded, load hymns for the selected hymnal.
      final hymnalProvider = context.read<HymnalProvider>();
      if (hymnalProvider.hymnals.isNotEmpty) {
        final selectedHymnal =
            hymnalProvider.hymnals[hymnalProvider.selectedHymnal];
        await context.read<HymnProvider>().loadHymns(selectedHymnal.language);
      }
    });

    _scrollController = ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (_scrollController.position.pixels >= 120 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      if (!_isScrollingDown) setState(() => _isScrollingDown = true);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) setState(() => _isScrollingDown = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Get the hymnal provider hymnal list.
    final hymnalProvider = context.watch<HymnalProvider>();

    /// Get the hymn provider.
    final hymnProvider = context.watch<HymnProvider>();

    return Scaffold(
      drawer: NahDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          MySliverAppBar(
            // Get the title from the provider.
            title: hymnalProvider.getHymnalTitle(),
            leading: Builder(
              builder: (context) {
                // Menu icon button.
                return IconButton(
                  onPressed: () => handleDrawerButton(context),
                  icon: Icon(Icons.menu),
                );
              },
            ),

            actions:
                ActionButtons.values
                    .map(
                      (button) => IconButton(
                        onPressed: () => button.onPressed(context),
                        icon: Icon(button.icon),
                      ),
                    )
                    .toList(),
          ),
          // Since all is dependent on the hymnal provider, show the progress indicator if hymnals or hymns are loading.
          hymnalProvider.isLoading || hymnProvider.isLoading
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  key: ValueKey('hymnScreenProgressIndicator'),
                  child: CircularProgressIndicator(),
                ),
              )
              : hymnalProvider.errorMessage != null &&
                  hymnalProvider.errorMessage!.isNotEmpty
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: ErroMessageWithRetry(key: ValueKey('hymnError')),
              )
              : SliverHymnList(
                key: ValueKey("sliverHymnList"),
                hymns: hymnProvider.hymnList,
              ),
        ],
      ),
      // Search hymn number using the FAB.
      floatingActionButton:
          _isScrollingDown
              ? SizedBox.shrink()
              : FloatingActionButton(
                key: ValueKey("searchHymnId"),
                onPressed:
                    () => showSearch(
                      context: context,
                      delegate: SearchHymnDelegate(searchingHymnId: true),
                    ),
                child: Icon(Icons.dialpad),
              ),
    );
  }

  /// Method to handle the opening & closing of the drawer.
  void handleDrawerButton(BuildContext context) {
    Scaffold.of(context).isDrawerOpen
        ? Scaffold.of(context).closeDrawer()
        : Scaffold.of(context).openDrawer();
  }
}
