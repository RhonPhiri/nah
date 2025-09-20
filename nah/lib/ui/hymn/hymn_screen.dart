import 'package:flutter/material.dart';
import 'package:nah/ui/core/ui/app_shell/view_model/app_layout.dart';

class HymnScreen extends StatelessWidget {
  const HymnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = AppLayout(MediaQuery.sizeOf(context).width);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: layout.isExtraLarge ? 2 : 1,
            child: Container(
              color: Colors.amber,
              child: Center(child: Text("Hymns")),
            ),
          ),
          if (layout.isExpanded || layout.isLarge || layout.isExtraLarge)
            Expanded(
              flex: layout.isExtraLarge ? 3 : 1,
              child: Container(
                color: Colors.lightBlue,
                child: Center(child: Text("Hymn Details")),
              ),
            ),
          if (layout.isExtraLarge)
            Expanded(
              flex: layout.isExtraLarge ? 2 : 1,
              child: Container(
                color: Colors.green,
                child: Center(child: Text("Hymnals")),
              ),
            ),
        ],
      ),
      floatingActionButton: layout.isCompact
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.dialpad_rounded),
            )
          : SizedBox.shrink(),
    );
  }
}
