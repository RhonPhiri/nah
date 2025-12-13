// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/result.dart';

import '../../testing/utils/result.dart';

void main() {
  group('Command0 tests', () {
    test('should complete a void function', () async {
      final command = Command0<void>(() => Future.value(Result.success(null)));

      await command.execute();

      expect(command.completed, true);
    });

    test('should complete a bool command', () async {
      final command = Command0(() => Future.value(Result.success(true)));

      await command.execute();

      expect(command.completed, true);
      expect(command.result?.asSuccess.data, true);
    });

    test('running should be true', () async {
      final command = Command0(() => Future.value(Result.success(null)));

      final future = command.execute();

      expect(command.running, true);

      await future;

      expect(command.running, false);
    });

    test('should only run once', () async {
      int count = 0;
      final command = Command0(() => Future.value(Result.success(count++)));

      final future = command.execute();

      command.execute();
      command.execute();
      command.execute();
      command.execute();

      await future;

      expect(count, 1);
    });

    test('should handle errors', () async {
      final command = Command0(
        () => Future.value(Result.error(Exception("ERROR ON TESTING"))),
      );

      await command.execute();

      expect(command.error, true);
      expect(command.result, isA<Error>());
    });
  });

  group('Command1 tests', () {
    test('complete a void command with a bool argument', () async {
      final command = Command1<void, bool>((a) {
        expect(a, true);
        return Future.value(Result.success(null));
      });

      await command.execute(true);

      expect(command.completed, true);
    });

    test('should complete a bool command with a bool argument', () async {
      final command = Command1<bool, bool>((a) {
        expect(a, true);
        return Future.value(Result.success(true));
      });

      await command.execute(true);

      expect(command.completed, true);
      expect(command.result?.asSuccess.data, true);
    });
  });
}
