import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/error_widget.dart';
import 'package:nah/ui/home/view_models/home_view_model.dart';
import 'package:nah/ui/home/widgets/drawer/nah_drawer.dart';
import 'package:nah/ui/home/widgets/home_body.dart';

/// Main screen for displaying hymns and searching/selecting hymnals.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeViewModel});
  final HomeViewModel homeViewModel;

  @override
  State<HomeScreen> createState() => _HymnScreenState();
}

class _HymnScreenState extends State<HomeScreen> {
  //Variable to hold the current scrolling status
  // bool _isScrollingDown = false;

  // late ScrollController _scrollController;

  // @override
  // void initState() {
  //   super.initState();
  //   //Delay the call to loadHymnals() until after the widget tree is built.
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await context.read<HymnalProvider>().loadHymnals();

  //     // If the widget is mounted in the widget tree, run the following callbacks.
  //     if (!mounted) return;
  //     // After hymnals are loaded, load hymns for the selected hymnal.
  //     final hymnalProvider = context.read<HymnalProvider>();
  //     if (hymnalProvider.hymnals.isNotEmpty) {
  //       final selectedHymnal =
  //           hymnalProvider.hymnals[hymnalProvider.selectedHymnal];
  //       await context.read<HymnProvider>().loadHymns(selectedHymnal.language);
  //     }
  //   });

  //   _scrollController = ScrollController()..addListener(scrollListener);
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void scrollListener() {
  //   if (_scrollController.position.pixels >= 120 &&
  //       _scrollController.position.userScrollDirection ==
  //           ScrollDirection.reverse) {
  //     if (!_isScrollingDown) setState(() => _isScrollingDown = true);
  //   } else if (_scrollController.position.userScrollDirection ==
  //       ScrollDirection.forward) {
  //     if (_isScrollingDown) setState(() => _isScrollingDown = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NahDrawer(),
      body: ListenableBuilder(
        key: ValueKey("HOMESCREEN_LISTENABLE_BUILDER"),
        listenable: widget.homeViewModel.load,
        builder: (context, child) {
          if (widget.homeViewModel.load.running) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.homeViewModel.load.error) {
            return ErrorIndicator(
              subject: "Hymns",
              onPressed: () => widget.homeViewModel.load.execute(),
            );
          }
          return child!;
        },
        child: HomeBody(
          hymnalTitle: "hymnalTitle",
          homeViewModel: widget.homeViewModel,
        ),
      ),
      // Search hymn number using the FAB.
      // floatingActionButton: _isScrollingDown
      //     ? SizedBox.shrink()
      //     : FloatingActionButton(
      //         key: ValueKey("searchHymnId"),
      //         onPressed: () => showSearch(
      //           context: context,
      //           delegate: SearchHymnDelegate(searchingHymnId: true),
      //         ),
      //         child: Icon(Icons.dialpad),
      //       ),
    );
  }
}
