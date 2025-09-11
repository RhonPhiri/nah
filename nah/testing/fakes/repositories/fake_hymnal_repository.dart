import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

import '../models/hymnal.dart';

class FakeHymnalRepository implements HymnalRepository {
  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    return Result.success([kHymnal]);
  }

  @override
  Future<Result<Hymnal>> getStoredHymnal() async {
    return Result.success(kHymnal);
  }

  @override
  Future<Result<void>> setHymnal(Hymnal hymnal) async {
    return Result.success(null);
  }
}
