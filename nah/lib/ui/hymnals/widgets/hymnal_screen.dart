import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/data/repositories/usage_status_repository.dart/usage_status_repository.dart';
import 'package:nah/ui/core/ui/error_button.dart';
import 'package:nah/ui/hymnals/view_model/hymnal_view_model.dart';
import 'package:provider/provider.dart';

class HymnalScreen extends StatefulWidget {
  const HymnalScreen({
    super.key,
    required this.viewModel,
    this.isOnboarding = false,
  });
  final HymnalViewModel viewModel;

  final bool isOnboarding;

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
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.viewModel.load.error) {
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
                SliverAppBar.medium(
                  title: Text(
                    widget.isOnboarding ? "Select a hymnal" : "Hymnals",
                  ),
                ),
                SliverList.builder(
                  itemCount: hymnals.length,
                  itemBuilder: (context, index) {
                    final hymnal = hymnals[index];
                    return ListTile(
                      key: ValueKey('hymnalListTile_$index'),
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
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onHymnalSelected() async {
    if (widget.viewModel.selectHymnal.completed) {
      if (widget.isOnboarding) {
        await context.read<UsageStatusRepository>().enterApp();
        return;
      }
      widget.viewModel.selectHymnal.clearResult();
      context.pop();
    }
  }
}
