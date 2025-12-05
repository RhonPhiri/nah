import 'package:flutter/material.dart';
import 'package:nah/utils/result.dart';

abstract class Command<T> extends ChangeNotifier {
  Result<T>? _result;
  Result<T>? get result => _result;

  /// bool to capture the running state of the action
  bool _running = false;
  bool get running => _running;

  /// Variabe to capture the error that might have arose on execution of the action
  bool _error = false;
  bool get error => _result is Error;

  /// bool to hold the state of completion of executing a task
  bool _completed = false;
  bool get completed => _result is Success;

  Future<void> _execute(Future<Result<T>> Function() action) async {
    /// prevent execution of same action if the action is running
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
      _completed = true;
    } finally {
      _running = false;
      notifyListeners();
    }
  }

  /// method to clear the most recent action result
  void clearResult() {
    _result = null;
    notifyListeners();
  }
}

final class Command0<T> extends Command<T> {
  final Future<Result<T>> Function() _action;

  Command0(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}

final class Command1<T, A> extends Command<T> {
  // A function with a single argument
  final Future<Result<T>> Function(A) _action;

  Command1(this._action);

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
