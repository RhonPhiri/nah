import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_layout.dart';

class HymnCollectionScreen extends StatelessWidget {
  const HymnCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = AppLayout(MediaQuery.sizeOf(context).width);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: layout.isExtraLarge ? 2 : 1,
            child: Container(
              color: Colors.brown,
              child: Center(child: Text("Hymn Collections")),
            ),
          ),
          if (layout.isExpanded || layout.isLarge || layout.isExtraLarge)
            Expanded(
              flex: layout.isExtraLarge ? 2 : 1,
              child: Container(
                color: Colors.orange,
                child: Center(child: Text("Hymns")),
              ),
            ),
          if (layout.isExtraLarge)
            Expanded(
              flex: layout.isExtraLarge ? 3 : 1,
              child: Container(
                color: Colors.purple,
                child: Center(child: Text("Hymn Details")),
              ),
            ),
        ],
      ),
    );
  }
}
