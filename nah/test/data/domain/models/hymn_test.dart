import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/domain/models/hymn/hymn.dart';

import '../../../../testing/fakes/models/hymn.dart';

void main() {
  group('test hymn model', () {
    test('creating a hymn object from json', () {
      final hymn = Hymn.fromJson(kHymnMap);
      expect(hymn, kHymn);
    });
    test('copywith method', () {
      final hymn = kHymn;
      Hymn hymn2 = hymn.copyWith(id: 2);

      expect(hymn2.id, 2);
    });
  });
}
