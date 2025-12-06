import 'package:flutter/material.dart';
import 'package:nah/ui/home/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel, required this.pages});
  final HomeViewModel viewModel;
  final List<Widget> pages;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.viewModel.selectedIdx);
    widget.viewModel.addListener(_onViewModelIndexChanged);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel) {
      oldWidget.viewModel.removeListener(_onViewModelIndexChanged);
      widget.viewModel.addListener(_onViewModelIndexChanged);
    }

    if (_pageController.hasClients) {
      _pageController.jumpToPage(widget.viewModel.selectedIdx);
    } else {
      _pageController = PageController(
        initialPage: widget.viewModel.selectedIdx,
      );
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelIndexChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: widget.viewModel.setSelectedIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: widget.viewModel,
        builder: (context, _) => NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.library_music_outlined),
              selectedIcon: Icon(Icons.library_music),
              label: "Hymns",
            ),
            NavigationDestination(
              icon: Icon(Icons.collections_bookmark_outlined),
              selectedIcon: Icon(Icons.collections_bookmark_rounded),
              label: "Hymn Collections",
            ),
            NavigationDestination(
              icon: Icon(Icons.info_outline_rounded),
              selectedIcon: Icon(Icons.info_rounded),
              label: "info",
            ),
          ],
          selectedIndex: widget.viewModel.selectedIdx,
          onDestinationSelected: widget.viewModel.setSelectedIndex,
        ),
      ),
    );
  }

  void _onViewModelIndexChanged() {
    final idx = widget.viewModel.selectedIdx;
    if (!_pageController.hasClients) return;

    final currentPage = (_pageController.page ?? _pageController.initialPage)
        .round();
    if (currentPage == idx) return;

    _pageController.jumpToPage(idx);
  }
}
