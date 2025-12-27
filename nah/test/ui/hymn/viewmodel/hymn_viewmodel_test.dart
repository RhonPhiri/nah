import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/ui/hymn/viewmodel/hymn_view_model.dart';

import '../../../../testing/fakes/data/repositories/fake_hymn_repository.dart';
import '../../../../testing/fakes/domain/models/hymn.dart';
import '../../../../testing/fakes/domain/models/hymnal.dart';

void main() {
  group('HymnViewModel Tests', () {
    late HymnViewModel viewmodel;
    late HymnRepository hymnRepository;
    setUp(() {
      hymnRepository = FakeHymnRepository();
      viewmodel = HymnViewModel(hymnRepository: hymnRepository);
    });

    tearDown(() {
      viewmodel.dispose();
    });

    test('shoud load hymns', () async {
      expect(viewmodel.hymns, isEmpty);

      await viewmodel.load.execute(kHymnal.id);

      expect(viewmodel.hymns, isNotEmpty);
    });
    test('Parser should assign the first hymn on hymnal change', () async {
      expect(viewmodel.selectedHymn.value, null);
      expect(viewmodel.hymns, isEmpty);
      await viewmodel.parse.execute(kHymnal);

      expect(viewmodel.hymns, isNotEmpty);
      expect(viewmodel.selectedHymn.value, isNotNull);
      expect(viewmodel.parse.completed, true);
    });

    test('Should find a match', () async {
      viewmodel.selectedHymn.value = Hymn(
        id: 10,
        title: "SELECTED_HYMN",
        details: {
          "sourceRef": "2 REF",
          "sourceTitle": "SELECTED_HYMN",
          "COMPOSER": "RHON",
        },
        lyrics: {
          "verses": ["VERSE_1", "VERSE_2"],
          "chorus": "CHORUS",
        },
      );

      await viewmodel.parse.execute(kHymnal);

      expect(viewmodel.selectedHymn.value, isNotNull);
      expect(viewmodel.selectedHymn.value, kEnglishHymn);
    });

    test(
      'Should Assign the first hymn of the list if no match was found',
      () async {
        viewmodel.selectedHymn.value = Hymn(
          id: 5,
          title: "SELECTED_HYMN",
          details: {
            "sourceRef": "1000 REF",
            "sourceTitle": "SELECTED_HYMN",
            "COMPOSER": "RHON",
          },
          lyrics: {
            "verses": ["VERSE_1", "VERSE_2"],
            "chorus": "CHORUS",
          },
        );
        await viewmodel.parse.execute(kHymnal);

        expect(viewmodel.selectedHymn.value, isNotNull);
        expect(viewmodel.selectedHymn.value, viewmodel.hymns.first);
      },
    );

    test('Should parse the id if the selected hymn is original', () async {
      viewmodel.selectedHymn.value = Hymn(
        id: 2,
        title: "SELECTED_HYMN",
        details: {"sourceRef": null, "sourceTitle": null, "COMPOSER": "RHON"},
        lyrics: {
          "verses": ["VERSE_1", "VERSE_2"],
          "chorus": "CHORUS",
        },
      );
      await viewmodel.parse.execute(kHymnal);

      expect(viewmodel.selectedHymn.value, isNotNull);
      expect(viewmodel.selectedHymn.value, viewmodel.hymns[0]);
    });
  });
}
