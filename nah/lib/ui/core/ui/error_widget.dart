import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    super.key,
    required this.onPressed,
    required this.subject,
  });

  final VoidCallback onPressed;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "There was an error while loading the $subject.\nPlease, press the retry button",
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: onPressed, child: Text("Retry")),
          ],
        ),
      ),
    );
  }
}
