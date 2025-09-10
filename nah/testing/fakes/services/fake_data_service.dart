import 'package:nah/data/service/embedded/data_service_embedded.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

import '../models/hymn.dart';
import '../models/hymnal.dart';

class FakeDataService implements DataServiceEmbedded {
  @override
  Future<List<Hymnal>> getHymnals() async {
    return Future.value([kHymnal]);
  }

  @override
  Future<List<Hymn>> getHymns(String language) async {
    return Future.value([kHymn]);
  }
}
