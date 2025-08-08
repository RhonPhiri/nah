import 'package:flutter/material.dart';
import 'package:nah/data/models/bookmark_model.dart';
import 'package:nah/data/models/hymn_model.dart';
import 'package:nah/ui/bookmarked_hymn/view_model/bookmarked_hymns_provider.dart';
import 'package:nah/ui/core/ui/no_data.dart';
import 'package:nah/ui/hymn_collection/widgets/create_hymn_collection_alert_dialog.dart';
import 'package:nah/ui/core/ui/modal_bot_sheet_container.dart';
import 'package:nah/ui/hymn_collection/view_model/hymn_collection_provider.dart';
import 'package:nah/ui/hymnal/view_model/hymnal_provider.dart';
import 'package:provider/provider.dart';

class HymnColBotSheet extends StatelessWidget {
  const HymnColBotSheet({super.key, required this.hymn});
  final Hymn hymn;

  @override
  Widget build(BuildContext context) {
    ///Variable holding the hymn collection provider instance.
    final hcProvider = context.watch<HymnCollectionProvider>();
    return ModalBotSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildColBotSheetTopBar(context, hcProvider),
          Expanded(
            child:
                hcProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : hcProvider.hcs.isEmpty
                    ? _buildCollectionsEmpty(context)
                    : _buildColBotSheetList(hcProvider),
          ),
        ],
      ),
    );
  }

  ///Method to build the hymn collection bottom sheet top bar with a create collection button
  Widget _buildColBotSheetTopBar(
    BuildContext context,
    HymnCollectionProvider hcProvider,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      alignment: Alignment.topRight,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        onPressed: () async {
          final newHc = await showDialog(
            context: context,
            builder: (context) => const CreateHymnCollectionAlertDialog(),
          );
          //Check if the user cancelled hc creation returning null or hc was created
          if (newHc != null) {
            //Check if the hymn collection is already created
            final isAlreadyCreated = hcProvider.hcs.any(
              (collection) =>
                  collection.title.toLowerCase() == newHc.title.toLowerCase(),
            );
            if (!isAlreadyCreated) {
              //create hymn collection
              await hcProvider.createHc(newHc);
            }
          }
        },

        child: const Text.rich(
          TextSpan(
            text: '+ ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Create New Collection',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Widget to display an empty illustration
  Widget _buildCollectionsEmpty(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You currently don't have any \nhymn collections.",
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        NoData(gender: "female"),
      ],
    );
  }

  ///Method to build a list of hymn collections
  Widget _buildColBotSheetList(HymnCollectionProvider hcProvider) {
    return ListView.builder(
      itemCount: hcProvider.hcs.length,
      itemBuilder: (context, index) {
        ///Variable to hold the list of hymn collections
        final hcs = hcProvider.hcs.reversed.toList();

        ///Variable to hold a particular hymn collection depending on its index
        final hc = hcs[index];

        ///variable to hold the bookmarked hymns
        final bms = context.watch<BookmarkedHymnsProvider>().bms;

        ///variable below holds the current selected hymnal
        final selectedHymnal =
            context.read<HymnalProvider>().getSelectedHymnal();

        ///varibale to hold a bookmarked hymn object
        final newBmH = Bookmark(
          id: hymn.id,
          title: hymn.title,
          language: selectedHymnal.language,
          hcTitle: hc.title,
        );

        ///Variable to hold the boolean of the implementation that checks if a hymn has already been bookmarked
        final isBookmarked = bms.any((bm) => bm == newBmH);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CheckboxListTile(
            key: ValueKey('hcBottomSheetCheckBox$index'),
            tileColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.2),
            title: Text('${index + 1}. ${hc.title}'),

            //This checkbox parameter represents a boolean true/ false. When true, the box is checked & vice versa
            value: isBookmarked,

            ///method that when a user checks or unchecks the checkbox, the hymn is added/ removed from the collection
            onChanged: (newValue) {
              //The new value is the opposite of the value parameter. I.e. it is the new boolean that will be assigned to value
              //If this hymn is bookmarked, value is true, hence the newValue will be false
              //checking that newValue is not null
              if (newValue == null) return;

              context.read<BookmarkedHymnsProvider>().toggleHcCheckBox(
                newValue: newValue,
                newBm: newBmH,
              );
            },
          ),
        );
      },
    );
  }
}
