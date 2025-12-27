import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/core/ui/error_button.dart';
import 'package:nah/ui/hymn/viewmodel/hymn_view_model.dart';
import 'package:nah/ui/hymn/widgets/compact_view.dart';
import 'package:nah/ui/hymn/widgets/non_compact_view.dart';
import 'package:nah/ui/hymnal/viewmodel/hymnal_view_model.dart';
import 'package:provider/provider.dart';

class HymnPage extends StatefulWidget {
  const HymnPage({
    super.key,
    required this.viewModel,
    required this.secondScreen,
    required this.thirdScreen,
  });
  final HymnViewModel viewModel;
  final Widget secondScreen;
  final Widget thirdScreen;

  @override
  State<HymnPage> createState() => _HymnPageState();
}

class _HymnPageState extends State<HymnPage> {
  late final ValueNotifier<Hymnal?> selectedHymnalNotifier;
  @override
  void initState() {
    super.initState();

    // Since the root is not the hymnal, they should be loaded on app startup
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (selectedHymnalNotifier.value == null) {
        await context.read<HymnalViewModel>().load.execute();
      }
    });
    // Instantiating the current a selected hymnal notifier
    selectedHymnalNotifier = context.read<HymnalViewModel>().selectedHymnal;

    // On value change, should call the _onHymnalSelected method that causes the hymns to reload
    selectedHymnalNotifier.addListener(_onHymnalSelected);
  }

  @override
  void dispose() {
    selectedHymnalNotifier.removeListener(_onHymnalSelected);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The first row holding the hymnlist + details screen and a hymnal screen
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: ListenableBuilder(
            listenable: widget.viewModel.load,
            builder: (context, child) {
              if (widget.viewModel.load.running) {
                return Center(child: CircularProgressIndicator());
              }
              if (widget.viewModel.load.error) {
                return Center(
                  child: ErrorButton(
                    text: "Error while loading hymns",
                    onPressed: () => widget.viewModel.load,
                  ),
                );
              }
              return child!;
            },
            child: ListenableBuilder(
              listenable: widget.viewModel.parse,
              builder: (context, child) {
                if (widget.viewModel.load.running) {
                  return Center(child: CircularProgressIndicator());
                }
                if (widget.viewModel.load.error) {
                  return Center(
                    child: ErrorButton(
                      text: "Error while loading hymns",
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

                  return Row(
                    children: [
                      Flexible(
                        child: Scaffold(
                          // Only show this app bar if the device is not compact or medium
                          appBar:
                              (Dimens(context).isCompact ||
                                  Dimens(context).isMedium)
                              ? null
                              : AppBar(
                                  title: Text(
                                    selectedHymnalNotifier.value?.title ?? "",
                                  ),
                                  scrolledUnderElevation: 0,
                                  elevation: 0,
                                  actions: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        context.push("/hymns/hymnals");
                                      },
                                      icon: Icon(Icons.auto_stories),
                                    ),
                                  ],
                                ),
                          // If compact/ medium show a sliver body and show a regular listview for other screen sizes
                          body:
                              (Dimens(context).isCompact ||
                                  Dimens(context).isMedium)
                              ? CompactSliverView(
                                  selectedHymnalNotifier:
                                      selectedHymnalNotifier,
                                  hymns: hymns,
                                  widget: widget,
                                )
                              : NonCompactListAndDetailsView(
                                  hymns: hymns,
                                  widget: widget,
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Dimens(context).isExtraLarge
            ? Flexible(child: widget.thirdScreen)
            : SizedBox.shrink(),
      ],
    );
  }

  void _onHymnalSelected() {
    widget.viewModel.load.clearResult();
    widget.viewModel.load.execute(selectedHymnalNotifier.value!.id);
  }
}
