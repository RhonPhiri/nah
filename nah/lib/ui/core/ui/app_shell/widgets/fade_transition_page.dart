import 'package:flutter/widgets.dart';

class FadeTransitionPage extends Page {
  final Widget child;

  const FadeTransitionPage({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    super.canPop,
    super.onPopInvoked,
    required this.child,
  });
  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
