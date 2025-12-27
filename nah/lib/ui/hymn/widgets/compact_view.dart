import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/ui/hymn/widgets/hymn_list_tile.dart';
import 'package:nah/ui/hymn/widgets/hymn_page.dart';

class CompactSliverView extends StatelessWidget {
  const CompactSliverView({
    super.key,
    required this.selectedHymnalNotifier,
    required this.hymns,
    required this.widget,
  });

  final ValueNotifier<Hymnal?> selectedHymnalNotifier;
  final List<Hymn> hymns;
  final HymnPage widget;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          title: Text(selectedHymnalNotifier.value?.title ?? ""),
          scrolledUnderElevation: 0,
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),

            IconButton(
              onPressed: () {
                context.push("/hymns/hymnals");
              },
              icon: Icon(Icons.auto_stories),
            ),
          ],
        ),
        SliverList.builder(
          itemCount: hymns.length,
          itemBuilder: (context, index) {
            final hymn = hymns[index];
            return HymnListTile(hymn: hymn, widget: widget);
          },
        ),
      ],
    );
  }
}
