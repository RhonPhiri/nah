import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';
import 'package:nah/ui/core/ui/sliver_list_empty.dart';
import 'package:nah/ui/hymn_collection/view_model/hymn_collection_provider.dart';
import 'package:nah/ui/hymn_collection/widgets/hymn_col_inkwell.dart';
import 'package:provider/provider.dart';

class HymnColScreen extends StatelessWidget {
  const HymnColScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = 'Collection';
    final hcProvider = context.watch<HymnCollectionProvider>();
    final hcs = hcProvider.hcs.reversed.toList();
    //color for checkboxes, iconButtons

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MySliverAppBar(title: title),

          SliverToBoxAdapter(child: SizedBox(height: 16)),
          //Allow to de/select all collections or nothing
          hcProvider.isLoading
              ? SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
              : hcs.isEmpty
              ? SliverListEmpty(
                message: "You currently don't have any \nHymn collections",
                emptyGender: "male",
              )
              : SliverList.separated(
                itemCount: hcs.length,
                itemBuilder: (context, index) {
                  final collection = hcs[index];

                  return HymnColInkwellButton(hc: collection, index: index);
                },
                separatorBuilder:
                    (context, index) => Container(
                      height: 2,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                    ),
              ),
        ],
      ),
    );
  }
}
