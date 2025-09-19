import 'package:flutter/material.dart';

class UnkownScreen extends StatelessWidget {
  const UnkownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("E R R O R"),
            SizedBox(height: 4),
            Text("/ 4 0 4"),
            SizedBox(height: 4),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
