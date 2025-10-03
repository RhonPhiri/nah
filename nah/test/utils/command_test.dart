import 'package:flutter_test/flutter_test.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/result.dart';

import '../../testing/utils/result.dart';

void main() {
  group('Command0 tests', () {
    test('Should complete a void method', () async {
      // Arrange
      final command = Command0<void>(() => Future.value(Result.success(null)));
      // Act
      await command.execute();
      // Assert
      expect(command.complete, true);
    });

    test('Should complete bool command', () async {
      // Arrange
      final command = Command0(() => Future.value(Result.success(true)));
      // Act
      await command.execute();
      // Assert
      expect(command.complete, true);
      expect(command.result!.asSuccess.data, true);
    });

    test('Running should be true', () async {
      // Arrange
      final command = Command0(() => Future.value(Result.success(true)));
      // Act
      final future = command.execute();
      // Assert
      expect(command.running, true);
      // Act
      await future;
      // Assert
      expect(command.running, false);
    });
    test('Should only run once', () async {
      int count = 0;
      final command = Command0<int>(
        () => Future.value(Result.success(count++)),
      );

      // When execute is called, the command is running. & when running, the _execute command should return & not continue
      final future = command.execute();
      command.execute();
      command.execute();
      command.execute();
      await future;
      expect(count, 1);
    });

    test('Should handle errors', () async {
      final command = Command0(
        () => Future.value(
          Result.failure(Exception("Failed loading data from repo")),
        ),
      );

      await command.execute();

      expect(command.error, true);
      expect(command.result, isA<Failure>());
    });
  });

  group('Command1 tests', () {
    test('Should complete a void function with a bool argument', () async {
      final command = Command1<void, bool>((bool argument) {
        expect(argument, true);
        return Future.value(Result.success(null));
      });

      await command.execute(true);

      expect(command.complete, true);
    });

    test('Should complete a bool command with a bool argument', () async {
      final command = Command1<bool, bool>((a) {
        expect(a, false);
        return Future.value(Result.success(a));
      });

      await command.execute(false);

      expect(command.complete, true);
      expect(command.result?.asSuccess.data, false);
    });
  });
}
