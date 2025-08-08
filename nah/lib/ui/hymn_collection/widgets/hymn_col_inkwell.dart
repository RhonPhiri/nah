import 'package:flutter/material.dart';
import 'package:nah/data/models/hymn_collection_model.dart';
import 'package:nah/ui/bookmarked_hymn/widgets/bookmarked_hymn_screen.dart';
import 'package:nah/ui/hymn_collection/widgets/del_alert_dialog.dart';
import 'package:nah/ui/ui_export.dart';
import 'package:provider/provider.dart';

class HymnColInkwellButton extends StatefulWidget {
  const HymnColInkwellButton({
    super.key,
    required this.hc,
    required this.index,
  });
  final HymnCollection hc;
  final int index;

  @override
  State<HymnColInkwellButton> createState() => _HymnColInkwellButtonState();
}

class _HymnColInkwellButtonState extends State<HymnColInkwellButton> {
  @override
  Widget build(BuildContext context) {
    ///parameter values for the text properties in the collection item
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    final navigator = Navigator.of(context);

    final hc = widget.hc;

    return Dismissible(
      key: ValueKey('hymnColInkwell_${widget.index}'),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.red),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Icon(Icons.delete),
      ),
      confirmDismiss: (direction) async {
        final hymnCollectionProvider = context.read<HymnCollectionProvider>();
        final bookmarkedHymnsProvider = context.read<BookmarkedHymnsProvider>();
        final deleteHc = await showDialog<bool>(
          context: context,
          builder: (context) => DelAlertDialog(hymnCollection: hc),
        );
        if (deleteHc != null) {
          if (deleteHc) {
            await hymnCollectionProvider.deleteHc(hc);
            await bookmarkedHymnsProvider.loadBms();
          }
          return deleteHc;
        }
        return false;
      },
      child: InkWell(
        key: ValueKey('hymnColInkwell_${widget.index}'),
        onTap: () async {
          ///assing the collection to the provider
          ///load the bookmarked hymns into the bookmarkedHymns list
          await context
              .read<BookmarkedHymnsProvider>()
              .loadBmHymnsForCollection(hc);

          navigator.push(
            MaterialPageRoute(
              builder: (context) => BookmarkedHymnScreen(collection: widget.hc),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Row to hold the index and title
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Row(
                      children: [
                        Text('${widget.index + 1}. ', style: textStyle),
                      ],
                    ),
                  ),
                  Text(
                    hc.title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: textStyle?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha(127),
                child: Consumer<BookmarkedHymnsProvider>(
                  builder: (context, bmProvider, child) {
                    final totalBms =
                        bmProvider.bms
                            .where((bm) => bm.hcTitle == hc.title)
                            .toList()
                            .length
                            .toString();
                    return Text(totalBms);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Shows a snackbar when a collection is deleted
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _buildSnackBar(
    BuildContext context,
    String title,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1500),
        content: Text("$title has been deleted successfully"),
      ),
    );
  }
}
