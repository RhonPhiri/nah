import 'package:flutter_test/flutter_test.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

import '../../../testing/fakes/models/hymnal.dart';

void main() {
  test('test name', () {
    expect(kHymnal.toMap(), {
      "id": 0,
      "title": "TITLE",
      "language": "LANGUAGE",
    });
  });
}
