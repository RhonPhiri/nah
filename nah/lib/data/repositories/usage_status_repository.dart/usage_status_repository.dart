import 'package:flutter/foundation.dart';

/// [UsageStatusRepository] manages the data that will determine whether the hymnal screen should be shown
/// at startup or not.
abstract class UsageStatusRepository extends ChangeNotifier {
  Future<bool> get isFirstTimeUser;

  Future<void> enterApp();
}
