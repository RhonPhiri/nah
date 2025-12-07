import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/hymn_details/widgets/details_screen.dart';
import 'package:nah/ui/hymnals/widgets/hymnal_screen.dart';

class HymnPage extends StatelessWidget {
  const HymnPage({
    super.key,
    required this.secondScreen,
    required this.thirdScreen,
  });
  final Widget secondScreen;
  final Widget thirdScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  title: Text("Hymnal Title"),
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),

                    !Dimens(context).isExtraLarge
                        ? IconButton(
                            onPressed: () =>
                                context.go(Routes.relativeHymnalsPath),
                            icon: Icon(Icons.menu_book),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                SliverList.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) => ListTile(
                    title: Text("Tile"),
                    onTap: () {
                      context.go(Routes.relativeDetails);
                    },
                  ),
                ),
              ],
            ),
          ),
          !(Dimens(context).isCompact || Dimens(context).isMedium)
              ? Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: secondScreen,
                  ),
                )
              : SizedBox.shrink(),
          Dimens(context).isExtraLarge
              ? Flexible(flex: 2, child: thirdScreen)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
