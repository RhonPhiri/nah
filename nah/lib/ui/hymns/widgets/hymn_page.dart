import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/routing/router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/core/ui/error_button.dart';
import 'package:nah/ui/hymns/viewmodel/hymn_view_model.dart';

class HymnPage extends StatefulWidget {
  const HymnPage({
    super.key,
    required this.viewModel,
    // required this.secondScreen,
    // required this.thirdScreen,
  });
  final HymnViewModel viewModel;
  // final Widget secondScreen;
  // final Widget thirdScreen;

  @override
  State<HymnPage> createState() => _HymnPageState();
}

class _HymnPageState extends State<HymnPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_listener);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel.load,
      builder: (context, child) {
        if (widget.viewModel.load.running) {
          return Center(child: CircularProgressIndicator());
        }
        if (widget.viewModel.load.error) {
          return Center(
            child: ErrorButton(
              text: "Error while loading hymnals",
              onPressed: () => widget.viewModel.load,
            ),
          );
        }
        return child!;
      },
      child: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final hymns = widget.viewModel.hymns;

          return Scaffold(
            body: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar.medium(
                        title: Text(widget.viewModel.hymnal?.title ?? "Hello"),
                        scrolledUnderElevation: 0,
                        elevation: 0,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),

                          !Dimens(context).isExtraLarge
                              ? IconButton(
                                  onPressed: () async {
                                    final newHymanl = await context.push(
                                      "/hymns/hymnals",
                                    );

                                    if (newHymanl != null) {
                                      widget.viewModel.setSelectedHymnal(
                                        newHymanl as Hymnal,
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.auto_stories),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      SliverList.separated(
                        itemCount: hymns.length,
                        itemBuilder: (context, index) {
                          final hymn = hymns[index];
                          return ListTile(
                            leading: Text("${hymn.id}."),
                            minLeadingWidth: 8,
                            leadingAndTrailingTextStyle: TextStyle(
                              // TODO: MAnage sizes on different screens
                              fontSize: 16,
                            ),
                            title: Text(hymn.title),
                            onTap: () {
                              // widget.viewModel.setSelectedHymn(hymn);
                              context.push("/hymns/details/${hymn.id}");
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(thickness: 0, height: 0),
                      ),
                    ],
                  ),
                ),
                // !(Dimens(context).isCompact || Dimens(context).isMedium)
                //     ? Flexible(
                //         flex: 3,
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
                //           child: widget.secondScreen,
                //         ),
                //       )
                //     : SizedBox.shrink(),
                // Dimens(context).isExtraLarge
                //     ? Flexible(flex: 2, child: widget.thirdScreen)
                //     : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _listener() {
    widget.viewModel.load.execute();
  }
}
