import 'package:flutter/material.dart';

class ErrorButton extends StatelessWidget {
  const ErrorButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: onPressed,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}
