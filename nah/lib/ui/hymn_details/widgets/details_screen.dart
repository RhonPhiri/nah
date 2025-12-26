import 'package:flutter/material.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/hymn/viewmodel/hymn_view_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.viewModel});

  final HymnViewModel viewModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        appBar: AppBar(),
        body: HymnColumn(viewModel: widget.viewModel),
      ),
    );
  }
}

class HymnColumn extends StatefulWidget {
  const HymnColumn({super.key, required this.viewModel});
  final HymnViewModel viewModel;

  @override
  State<HymnColumn> createState() => _HymnColumnState();
}

class _HymnColumnState extends State<HymnColumn> {
  @override
  Widget build(BuildContext context) {
    final hymns = widget.viewModel.hymns;

    return widget.viewModel.selectedHymnNotifier.value == null
        ? Container(color: Colors.amber)
        : SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: PageView.builder(
              itemCount: hymns.length,
              onPageChanged: (index) {},
              itemBuilder: (context, index) {
                final hymn = hymns[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SelectableRegion(
                      selectionControls: MaterialTextSelectionControls()
                        ..buildHandle(
                          context,
                          TextSelectionHandleType.collapsed,
                          16,
                        ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          hymnTitle(hymn),

                          _englishHymnal(hymn),

                          _englishTitle(hymn),

                          Divider(thickness: 0),

                          ..._lyricsBuilder(hymn),

                          const SizedBox(height: 16),

                          Center(child: _composer(hymn)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget hymnTitle(Hymn hymn) {
    return Row(
      crossAxisAlignment: .start,
      mainAxisSize: .max,
      children: [
        Text(
          "${hymn.id}.",
          maxLines: 3,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,

            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            hymn.title,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,

              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _lyricsBuilder(Hymn hymn) {
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

  Widget _englishHymnal(Hymn hymn) {
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

  Widget _englishTitle(Hymn hymn) {
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

  Widget _composer(Hymn hymn) {
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
