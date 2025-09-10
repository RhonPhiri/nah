import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nah/routing/routes.dart';
import 'package:nah/ui/core/theme/colors.dart';
import 'package:nah/ui/core/ui/error_widget.dart';
import 'package:nah/ui/core/ui/my_sliver_app_bar.dart';
import 'package:nah/ui/on_boarding/view_model/on_boarding_view_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key, required this.onBoardingViewModel});

  final OnBoardingViewModel onBoardingViewModel;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static const _onBoardingTitle = "Select your hymnal";

  @override
  void initState() {
    super.initState();
    widget.onBoardingViewModel.enterApp.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant OnBoardingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.onBoardingViewModel.enterApp.removeListener(_onResult);
    widget.onBoardingViewModel.enterApp.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.onBoardingViewModel.enterApp.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        key: ValueKey("ONBOARDINGSCREEN_LISTENABLE_BUILDER_1"),
        listenable: widget.onBoardingViewModel.load,
        builder: (context, child) {
          if (widget.onBoardingViewModel.load.running) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.onBoardingViewModel.load.error) {
            return ErrorIndicator(
              subject: "Hymnals",
              onPressed: () => widget.onBoardingViewModel.load
                ..clearResult()
                ..execute(),
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          key: ValueKey("ONBOARDINGSCREEN_LISTENABLE_BUILDER_2"),
          listenable: widget.onBoardingViewModel.load,
          builder: (context, _) => CustomScrollView(
            slivers: [
              MySliverAppBar(
                leading: SizedBox.shrink(),
                title: _onBoardingTitle,
              ),
              SliverList.separated(
                itemCount: widget.onBoardingViewModel.hymnals.length,
                itemBuilder: (context, index) {
                  final hymnal = widget.onBoardingViewModel.hymnals[index];
                  return ListTile(
                    key: ValueKey('hymnalListTile_$index'),
                    leading: Icon(
                      Icons.book_rounded,
                      size: 40,
                      color: AppColors.blue2,
                    ),
                    title: Text(hymnal.title),
                    subtitle: Text(hymnal.language),

                    onTap: () =>
                        widget.onBoardingViewModel.enterApp.execute(hymnal),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.onBoardingViewModel.enterApp.complete) {
      widget.onBoardingViewModel.enterApp.clearResult();
      context.go(Routes.homePath);
    }
  }
}
