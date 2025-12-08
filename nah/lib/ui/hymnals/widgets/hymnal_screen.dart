import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/ui/error_button.dart';
import 'package:nah/ui/hymnals/view_model/hymnal_view_model.dart';

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
    widget.viewModel.selectHymnalId.addListener(_onHymnalSelected);
  }

  @override
  void dispose() {
    widget.viewModel.selectHymnalId.removeListener(_onHymnalSelected);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) context.go(Routes.home);
      },
      child: Scaffold(
        body: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running ||
                widget.viewModel.getHymnalId.running) {
              return CircularProgressIndicator();
            }
            if (widget.viewModel.load.error ||
                widget.viewModel.getHymnalId.error) {
              return ErrorButton(text: "Error while loading hymnals");
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
                      return ListTile(
                        key: ValueKey('hymnalListTile_$index'),
                        leading: Icon(
                          (widget.viewModel.selectedHymnalId == index)
                              ? Icons.book_rounded
                              : Icons.book_outlined,
                          size: 48,
                        ),
                        title: Text(hymnal.title),
                        subtitle: Text(hymnal.language),
                        onTap: () async => await widget.viewModel.selectHymnalId
                            .execute(index),
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

  void _onHymnalSelected() {
    if (widget.viewModel.selectHymnalId.completed) {
      widget.viewModel.selectHymnalId.clearResult();
      context.pop();
    }
  }
}
