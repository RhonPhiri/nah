import 'package:flutter/material.dart';
import 'package:nah/ui/core/theme/dimens.dart';
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
    final isLargeScreen =
        Dimens(context).isLarge || Dimens(context).isExtraLarge;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Row(
          children: [
            !Dimens(context).isCompact
                ? AnimatedBuilder(
                    key: ValueKey("HOME_NAVIGATION_RAIL"),
                    animation: widget.viewModel,
                    builder: (context, _) {
                      return NavigationRail(
                        groupAlignment: -0.85,
                        extended: isLargeScreen,

                        minExtendedWidth: 160,
                        labelType: !isLargeScreen
                            ? NavigationRailLabelType.selected
                            : NavigationRailLabelType.none,

                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(Icons.library_music_outlined),
                            selectedIcon: Icon(Icons.library_music),

                            label: Text("Hymns"),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.collections_bookmark_outlined),
                            selectedIcon: Icon(
                              Icons.collections_bookmark_rounded,
                            ),

                            label: Text("Collections"),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.info_outline_rounded),
                            selectedIcon: Icon(Icons.info_rounded),

                            label: Text("Info"),
                          ),
                        ],
                        selectedIndex: widget.viewModel.selectedIdx,
                        onDestinationSelected:
                            widget.viewModel.setSelectedIndex,
                      );
                    },
                  )
                : SizedBox.shrink(),
            Flexible(
              child: PageView(
                controller: _pageController,
                onPageChanged: widget.viewModel.setSelectedIndex,
                children: widget.pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Dimens(context).isCompact
            ? AnimatedBuilder(
                key: ValueKey("HOME_NAVIGATION_BAR"),
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
                      label: "Collections",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.info_outline_rounded),
                      selectedIcon: Icon(Icons.info_rounded),
                      label: "Info",
                    ),
                  ],
                  selectedIndex: widget.viewModel.selectedIdx,
                  onDestinationSelected: widget.viewModel.setSelectedIndex,
                ),
              )
            : SizedBox.shrink(),
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
