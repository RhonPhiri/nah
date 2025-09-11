import 'package:nah/data/repository/hymn/hymn_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

import '../models/hymn.dart';

class FakeHymnRepository implements HymnRepository {
  @override
  Future<Result<List<Hymn>>> getHymns(String hymnalLanguage) async {
    return Result.success([kHymn]);
  }
}
