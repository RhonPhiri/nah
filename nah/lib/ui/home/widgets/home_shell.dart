import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/ui/core/theme/dimens.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.navigationShell,
    required this.children,
  });
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;
  // final List<Widget> pages;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(covariant HomeShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newIndex = widget.navigationShell.currentIndex;
    if ((_pageController.hasClients ? _pageController.page?.round() : null) !=
        newIndex) {
      _pageController.animateToPage(
        newIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
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
        body: isLargeScreen
            ? Row(
                children: [
                  !Dimens(context).isCompact
                      ? NavigationRail(
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
                          selectedIndex: widget.navigationShell.currentIndex,
                          onDestinationSelected: _onDestinationSelected,
                        )
                      : SizedBox.shrink(),
                  Flexible(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: widget.navigationShell.goBranch,
                      children: widget.children,
                    ),
                  ),
                ],
              )
            : PageView(
                controller: _pageController,
                onPageChanged: widget.navigationShell.goBranch,
                children: widget.children,
              ),
        bottomNavigationBar: Dimens(context).isCompact
            ? NavigationBar(
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.my_library_music_outlined),
                    selectedIcon: Icon(Icons.my_library_music),
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
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: _onDestinationSelected,
              )
            : SizedBox.shrink(),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(index);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }
}
