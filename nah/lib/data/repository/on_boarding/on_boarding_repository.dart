import 'package:flutter/widgets.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

/// [OnBoardingRepository] checks the status of usage of the app, whether its first time or not.
/// The logic implemented is that of authentication From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
abstract class OnBoardingRepository extends ChangeNotifier {
  ///Variable to hold the current usage status
  Future<bool> get isInitialLaunch;

  ///Method to store the selected hymnal language on first startup & update the use status
  Future<Result<void>> enterApp({required Hymnal hymnal});
}
