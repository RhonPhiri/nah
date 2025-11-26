import 'package:flutter_test/flutter_test.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository_dev.dart';
import 'package:nah/data/services/data_service.dart';
import 'package:nah/utils/result.dart';
import '../../../testing/fakes/data/service/fake_data_service.dart';
import '../../../testing/utils/result.dart';

void main() {
  group('HymnalRepository tests', () {
    late DataService dataService;
    late HymnalRepository hymnalRepository;

    setUpAll(() {
      dataService = FakeDataService();
      hymnalRepository = HymnalRepositoryDev(dataService: dataService);
    });

    test('should get hymnals', () async {
      final result = await hymnalRepository.getHymnals();

      expect(result, isA<Success>());
      expect(result.asSuccess.data.length, 1);
      expect(result.asSuccess.data.first.language, "LANGUAGE");
    });
  });
}
