import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/data/repositories/hymn/hymn_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('Hymn repository tests', () {
    late DataService dataService;
    late HymnRepository hymnRepository;
    setUpAll(() {
      dataService = FakeDataService();
      hymnRepository = HymnRepositoryDev(dataService: dataService);
    });

    test('should get hymns', () async {
      final result = await hymnRepository.getHymns('en');

      expect(result, isA<Success>());
      expect(result.asSuccess.data.length, 1);
      expect(result.asSuccess.data.first.title, "HYMN_TITLE");
    });
  });
}
