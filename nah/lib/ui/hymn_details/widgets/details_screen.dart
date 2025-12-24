import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';
import 'package:nah/ui/hymns/viewmodel/hymn_view_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.hymnId,
    required this.viewModel,
  });

  final int hymnId;
  final HymnViewModel viewModel;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.hymnId - 1);
  }

  @override
  Widget build(BuildContext context) {
    final hymns = widget.viewModel.hymns;
    return PopScope(
      canPop: true,

      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: hymns.length,
          itemBuilder: (context, index) {
            final hymn = hymns[index];
            return HymnColumn(hymn: hymn);
          },
        ),
      ),
    );
  }
}

class HymnColumn extends StatelessWidget {
  const HymnColumn({super.key, required this.hymn});

  final Hymn hymn;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MySliverAppBar(title: hymnTitle),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableRegion(
              selectionControls: MaterialTextSelectionControls()
                ..buildHandle(context, TextSelectionHandleType.collapsed, 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  _englishHymnal,

                  _englishTitle,

                  Divider(thickness: 0),

                  ..._lyricsBuilder,

                  const SizedBox(height: 16),

                  Center(child: _composer),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String get hymnTitle => "${hymn.id}. ${hymn.title}";

  List<Widget> get _lyricsBuilder {
    return switch (hymn.lyrics) {
      {"verses": final verses, "chorus": final chorus} => [
        if (chorus.isNotEmpty) ...[
          for (var i = 0; i < verses.length; i++) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                verses[i],
                style: TextStyle(
                  height: 1.5,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            if (i == 0)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  chorus,
                  style: TextStyle(
                    fontSize: 24 + 1,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ] else
          for (final verse in verses)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                verse,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
      ],
      _ => [],
    };
  }

  Widget get _englishHymnal {
    final data = hymn.details["englishHymnal"];
    return data != null
        ? Text(
            data,
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        : SizedBox.shrink();
  }

  Widget get _englishTitle {
    final data = hymn.details["englishTitle"];
    return data != null
        ? SelectableText(
            data,
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        : SizedBox.shrink();
  }

  Widget get _composer {
    final data = hymn.details["composer"];
    return data != null
        ? SelectableText(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        : SizedBox.shrink();
  }
}
