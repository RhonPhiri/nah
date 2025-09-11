import 'package:flutter_test/flutter_test.dart';
import 'package:nah/domain/use_cases/hymn/load_hymn_use_case.dart';
import 'package:nah/utils/result.dart';
import '../../../../testing/fakes/repositories/fake_hymn_repository.dart';
import '../../../../testing/fakes/repositories/fake_hymnal_repository.dart';
import '../../../../testing/utils/result.dart';

void main() {
  group('LoadHymnUseCase tests', () {
    late LoadHymnUseCase loadHymnUseCase;
    late FakeHymnRepository fakeHymnRepository;
    late FakeHymnalRepository fakeHymnalRepository;

    //ARRANGE
    setUpAll(() {
      fakeHymnRepository = FakeHymnRepository();
      fakeHymnalRepository = FakeHymnalRepository();
      loadHymnUseCase = LoadHymnUseCase(
        hymnRepository: fakeHymnRepository,
        hymnalRepository: fakeHymnalRepository,
      );
    });
    test('fetch hymns', () async {
      //ACT
      final result = await loadHymnUseCase.fetchHymns();
      //ASSERT
      expect(result, isA<Success>());
      //ACT
      final hymnalTitle = result.asSuccess.data.hymnalTitle;
      //ASSERT
      expect(hymnalTitle, "TITLE");
      //ACT
      final hymns = result.asSuccess.data.hymns;
      //ASSERT
      expect(hymns.length, 1);
    });
  });
}
