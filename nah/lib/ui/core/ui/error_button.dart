import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';

class ErrorButton extends StatelessWidget {
  const ErrorButton({super.key, required this.text});
  final String text;

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
            onPressed: () => context.go(Routes.home),
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
