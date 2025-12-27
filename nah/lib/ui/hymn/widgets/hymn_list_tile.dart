import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/hymn/widgets/hymn_page.dart';

class HymnListTile extends StatelessWidget {
  const HymnListTile({super.key, required this.hymn, required this.widget});

  final Hymn hymn;
  final HymnPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
      child: ListTile(
        tileColor: Colors.white70,
        leading: Text("${hymn.id}."),
        minLeadingWidth: 8,
        leadingAndTrailingTextStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(hymn.title),
        onTap: () {
          widget.viewModel.selectedHymn.value = hymn;
          if (Dimens(context).isCompact || Dimens(context).isMedium) {
            context.push("/hymns/details");
          }
        },
      ),
    );
  }
}
