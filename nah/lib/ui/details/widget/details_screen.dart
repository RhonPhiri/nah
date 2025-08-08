import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nah/data/models/hymn_model.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';
import 'package:nah/ui/details/widget/flow_menu/flow_menu.dart';
import 'package:nah/ui/details/widget/hymn_column.dart';

/// Screen that displays the details of a single hymn.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.hymn});
  final Hymn hymn;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  //Variable to hold the current scrolling status
  bool _isScrollingDown = false;

  // //variable to hold the AudioProvider object instance
  // late AudioProvider _audioProvider;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // _audioProvider = AudioProvider(hymn: widget.hymn);
    _scrollController = ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _audioProvider.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (_scrollController.position.pixels >= 120 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      if (!_isScrollingDown) setState(() => _isScrollingDown = true);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) setState(() => _isScrollingDown = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          MySliverAppBar(
            key: ValueKey("DetailsScreenSliverAppBar"),
            title: hymnTitle,
            // actions: [_buildAudioButton()],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HymnColumn(hymn: widget.hymn),
            ),
          ),
        ],
      ),

      /// Floating action button menu for actions related to the hymn.
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child:
            _isScrollingDown
                ? SizedBox.shrink(key: ValueKey("FlowMenuHide"))
                : FlowMenu(key: ValueKey("FlowMenuShow"), hymn: widget.hymn),
      ),
    );
  }

  String get hymnTitle => "${widget.hymn.id}. ${widget.hymn.title}";

  // Widget _buildAudioButton() {
  //   return ListenableBuilder(
  //     listenable: _audioProvider,
  //     builder:
  //         (context, _) =>
  //             _audioProvider.searchingAudio
  //                 ? Center(child: CircularProgressIndicator())
  //                 : _audioProvider.hasAudio
  //                 ? AnimatedRotation(
  //                   turns: _audioProvider.isPlaying ? 1.0 : 0.0,
  //                   curve: Curves.decelerate,
  //                   duration: Duration(milliseconds: 320),
  //                   child: FloatingActionButton.small(
  //                     onPressed: () {
  //                       _audioProvider.handlePlayer();
  //                       debugPrint(
  //                         "Audio is playing: ${_audioProvider.isPlaying}",
  //                       );
  //                     },
  //                     child: Icon(
  //                       _audioProvider.isPlaying
  //                           ? Icons.pause_rounded
  //                           : Icons.play_arrow_rounded,
  //                     ),
  //                   ),
  //                 )
  //                 : SizedBox.shrink(),
  //   );
  // }
}
