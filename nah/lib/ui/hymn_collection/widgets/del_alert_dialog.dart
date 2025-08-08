import 'package:flutter/material.dart';
import 'package:nah/data/models/hymn_collection_model.dart';

class DelAlertDialog extends StatelessWidget {
  const DelAlertDialog({super.key, required this.hymnCollection});
  final HymnCollection hymnCollection;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: Icon(Icons.delete),
      title: Text("Are you sure you want to delete ${hymnCollection.title}?"),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text("Yes", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("No"),
        ),
      ],
    );
  }
}
