import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/domain/models/hymnal/hymnal.dart';

import '../../../../testing/fakes/models/hymnal.dart';

void main() {
  group('test hymn model', () {
    test('creating a hymn object from json', () {
      final hymnal = Hymnal.fromJson(kHymnalMap);
      expect(hymnal, kHymnal);
    });
    test('copywith method', () {
      final hymnal = kHymnal;
      Hymnal hymnal2 = hymnal.copyWith(id: 2);

      expect(hymnal2.id, 2);
    });
  });
}
