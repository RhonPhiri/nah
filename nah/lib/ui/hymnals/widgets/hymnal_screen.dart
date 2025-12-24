import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/ui/core/ui/error_button.dart';
import 'package:nah/ui/hymnals/viewmodel/hymnal_view_model.dart';

class HymnalScreen extends StatefulWidget {
  const HymnalScreen({super.key, required this.viewModel});
  final HymnalViewModel viewModel;

  @override
  State<HymnalScreen> createState() => _HymnalScreenState();
}

class _HymnalScreenState extends State<HymnalScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.selectHymnal.addListener(_onHymnalSelected);
  }

  @override
  void dispose() {
    widget.viewModel.selectHymnal.removeListener(_onHymnalSelected);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(child: CircularProgressIndicator());
            }
            if (widget.viewModel.load.error) {
              return ErrorButton(
                text: "Error while loading hymnals",
                onPressed: () => context.go("/"),
              );
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final hymnals = widget.viewModel.hymnals;
              return CustomScrollView(
                slivers: [
                  SliverAppBar.medium(title: Text("Hymnals")),
                  SliverList.builder(
                    itemCount: hymnals.length,
                    itemBuilder: (context, index) {
                      final hymnal = hymnals[index];

                      return Material(
                        color: Theme.of(context).cardColor,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          key: ValueKey('hymnalListTile_$index'),
                          splashColor: Colors.transparent,
                          leading: Icon(
                            (widget.viewModel.selectedHymnal?.id == hymnal.id)
                                ? Icons.book_rounded
                                : Icons.book_outlined,
                            size: 48,
                          ),
                          title: Text(hymnal.title),
                          subtitle: Text(hymnal.language),
                          onTap: () =>
                              widget.viewModel.selectHymnal.execute(hymnal),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onHymnalSelected() async {
    if (widget.viewModel.selectHymnal.completed) {
      widget.viewModel.selectHymnal.clearResult();
      if (mounted) context.pop(widget.viewModel.selectedHymnal);
    }
  }
}
