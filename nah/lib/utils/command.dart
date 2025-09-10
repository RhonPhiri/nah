//This command class contains all teh implementation to execute an action & update state where necessary
//Chagen notifier has been extended to expose the notifyListeners() method
import 'package:flutter/material.dart';
import 'package:nah/utils/result.dart';

///Type of method to be executed with zero arguments
typedef CommandAction0<T> = Future<Result<T>> Function();

///Type of method to be executed with arguments
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

class Command<T> extends ChangeNotifier {
  bool _running = false;

  ///True when the action is being executed
  bool get running => _running;

  Result<T>? _result;

  Result<T>? get result => _result;

  ///True if the action completed with success
  bool get complete => _result is Success;

  ///True if the action completed with an error
  bool get error => _result is Error;

  ///Clear last action result
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    ///Prevent the action from running multiple times
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();
    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command0] that executes a function without arguments
class Command0<T> extends Command<T> {
  final CommandAction0<T> _action;

  Command0(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}

/// [Command1] that executes a function with arguments
class Command1<T, A> extends Command<T> {
  final CommandAction1<T, A> _action1;

  Command1(this._action1);

  Future<void> execute(A arguments) async {
    await _execute(() => _action1(arguments));
  }
}
