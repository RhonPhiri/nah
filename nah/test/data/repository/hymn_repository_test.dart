import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/repositories/hymn/hymn_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('HymnRepository tests', () {
    late DataService dataService;
    late HymnRepository hymnRepository;
    setUpAll(() {
      dataService = FakeDataService();
      hymnRepository = HymnRepositoryDev(dataService: dataService);
    });

    test('should get hymns', () async {
      final result = await hymnRepository.getHymns(1);

      expect(result, isA<Success>());
      expect(result.asSuccess.data.length, 1);
      expect(result.asSuccess.data.first.details["source"], "ENGLISH_HYMNAL");
    });

    test('should get a specific hymns', () async {
      final result = await hymnRepository.getHymns(1, hymnId: 1);

      expect(result, isA<Success>());
      expect(result.asSuccess.data.length, 1);
      expect(result.asSuccess.data.first.details["source"], "ENGLISH_HYMNAL");
    });
  });
}
