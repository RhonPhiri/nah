import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/ui/core/theme/dimens.dart';
import 'package:nah/ui/hymn/viewmodel/hymn_view_model.dart';
import 'package:nah/ui/hymnal/viewmodel/hymnal_view_model.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.viewModel});

  final HymnViewModel viewModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late PageController _pageController;
  late ValueNotifier<Hymnal?> _selectedHymnalNotifier;

  @override
  void initState() {
    super.initState();
    // Instantiating the current selected hymnal
    _selectedHymnalNotifier = context.read<HymnalViewModel>().selectedHymnal;

    _selectedHymnalNotifier.addListener(_onHymnalSelected);
    // Instantiating the pagecontroller
    // If the selectedhymn is not null, then use its id to jump the pageview to that hymn. Else, go to the initial page
    _pageController = PageController(
      initialPage: (widget.viewModel.selectedHymn.value != null)
          ? (widget.viewModel.selectedHymn.value!.id - 1)
          : 0,
    );
    widget.viewModel.selectedHymn.addListener(_onHymnSelected);
  }

  @override
  void dispose() {
    _selectedHymnalNotifier.removeListener(_onHymnalSelected);
    widget.viewModel.selectedHymn.removeListener(_onHymnSelected);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final hymns = widget.viewModel.hymns;

    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final hymns = widget.viewModel.hymns;

        return PopScope(
          child: Scaffold(
            // Showing a transparent appbar
            extendBodyBehindAppBar: true,

            // extendBody: true,
            appBar: (Dimens(context).isCompact || Dimens(context).isMedium)
                ? AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      (Dimens(context).isCompact || Dimens(context).isMedium)
                          ? IconButton.filled(
                              onPressed: () {},
                              icon: Icon(Icons.text_fields),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.text_fields),
                            ),
                      (Dimens(context).isCompact || Dimens(context).isMedium)
                          ? IconButton.filled(
                              onPressed: () {
                                context.push("/hymns/details/hymnals");
                              },
                              icon: Icon(Icons.auto_stories),
                            )
                          : IconButton(
                              onPressed: () {
                                context.push("/hymns/details/hymnals");
                              },
                              icon: Icon(Icons.auto_stories),
                            ),
                    ],
                  )
                : null,
            body: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: PageView.builder(
                controller: _pageController,
                itemCount: hymns.length,
                itemBuilder: (context, index) {
                  final hymn = hymns[index];
                  final topInsert =
                      Dimens(context).isCompact || Dimens(context).isMedium
                      ? kToolbarHeight + 16
                      : 16.0;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.0,
                        (topInsert),
                        16.0,
                        16.0,
                      ),
                      child: SelectableRegion(
                        selectionControls: MaterialTextSelectionControls()
                          ..buildHandle(
                            context,
                            TextSelectionHandleType.collapsed,
                            16,
                          ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment:
                                Dimens(context).isCompact ||
                                    Dimens(context).isExpanded
                                ? .start
                                : .center,
                            children: [
                              hymnTitle(hymn),

                              _sourceRef(hymn),

                              _sourceTitle(hymn),

                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.5,
                              ),

                              ..._lyricsBuilder(hymn),

                              const SizedBox(height: 16),

                              Center(child: _composer(hymn)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  widget.viewModel.selectedHymn.value = hymns[index];
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget hymnTitle(Hymn hymn) {
    return Text(
      hymn.title,
      maxLines: 3,
      textAlign: Dimens(context).isCompact || Dimens(context).isExpanded
          ? .start
          : .center,

      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,

        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  List<Widget> _lyricsBuilder(Hymn hymn) {
    final TextAlign textAlign =
        Dimens(context).isCompact || Dimens(context).isExpanded
        ? .start
        : .center;
    return switch (hymn.lyrics) {
      {"verses": final verses, "chorus": final chorus} => [
        if (chorus.isNotEmpty) ...[
          for (var i = 0; i < verses.length; i++) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                verses[i],
                textAlign: textAlign,

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
                  textAlign: textAlign,

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
                textAlign: textAlign,

                style: TextStyle(
                  height: 1.5,
                  fontSize: 24,
                  fontWeight: .normal,
                ),
              ),
            ),
      ],
      _ => [],
    };
  }

  Widget _sourceRef(Hymn hymn) {
    final data = hymn.details["sourceRef"] as String?;
    if (data == null || data.trim().isEmpty) return SizedBox.shrink();
    return Text(
      data,
      style: TextStyle(height: 1.5, fontSize: 18, fontWeight: FontWeight.w300),
    );
  }

  Widget _sourceTitle(Hymn hymn) {
    final data = hymn.details["sourceTitle"] as String?;
    if (data == null || data.trim().isEmpty) return SizedBox.shrink();
    return SelectableText(
      data,
      style: TextStyle(height: 1.5, fontSize: 18, fontWeight: FontWeight.w300),
    );
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

  void _onHymnSelected() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(widget.viewModel.selectedHymn.value!.id - 1);
    }
  }

  void _onHymnalSelected() {
    widget.viewModel.parse.clearResult();
    widget.viewModel.parse.execute(_selectedHymnalNotifier.value!);
  }
}
