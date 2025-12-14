import 'package:logging/logging.dart';
import 'package:nah/data/repositories/usage_status_repository.dart/usage_status_repository.dart';
import 'package:nah/data/services/shared_pref_service.dart';
import 'package:nah/utils/result.dart';

class UsageStatusRepositoryDev extends UsageStatusRepository {
  UsageStatusRepositoryDev({required SharedPrefService sharedPrefService})
    : _sharedPrefService = sharedPrefService;
  final _log = Logger("UsageStatusRepositoryDev");

  final SharedPrefService _sharedPrefService;
  bool? _isFirstTimeUser;

  Future<void> _fetch() async {
    final result = await _sharedPrefService.fetchUsageState();
    switch (result) {
      case Success<bool?>():
        _isFirstTimeUser = result.data == null;
      case Error<bool?>():
        _log.severe(
          "Failed to fetch the usage status from shared preferences",
          result.error,
        );
    }
  }

  @override
  Future<void> enterApp() async {
    try {
      _isFirstTimeUser = false;
      await _sharedPrefService.saveUsageStatus();
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<bool> get isFirstTimeUser async {
    if (_isFirstTimeUser != null) {
      return _isFirstTimeUser!;
    }

    await _fetch();
    return _isFirstTimeUser ?? true;
  }
}
