import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: ConstrainedBox(
            constraints: constraints.tighten(width: 600),
            child: Container(
              color: Colors.green,
              child: Center(child: Text("About")),
            ),
          ),
        ),
      ),
    );
  }
}
