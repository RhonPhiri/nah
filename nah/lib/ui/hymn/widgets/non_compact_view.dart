import 'package:flutter/material.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/hymn/widgets/hymn_list_tile.dart';
import 'package:nah/ui/hymn/widgets/hymn_page.dart';

class NonCompactListAndDetailsView extends StatelessWidget {
  const NonCompactListAndDetailsView({
    super.key,
    required this.hymns,
    required this.widget,
  });

  final List<Hymn> hymns;
  final HymnPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: hymns.length,
            itemBuilder: (context, index) {
              final hymn = hymns[index];
              return HymnListTile(hymn: hymn, widget: widget);
            },
          ),
        ),
        !(Dimens(context).isCompact || Dimens(context).isMedium)
            ? Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: widget.secondScreen,
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
