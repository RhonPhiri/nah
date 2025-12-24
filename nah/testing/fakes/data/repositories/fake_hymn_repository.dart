import 'package:flutter/foundation.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

import '../../domain/models/hymn.dart';

class FakeHymnRepository implements HymnRepository {
  @override
  Future<Result<List<Hymn>>> getHymns(int hymnalId, {int? hymnId}) async {
    if (hymnId != null) {
      return SynchronousFuture(Result.success([kLocalHymn]));
    }
    return SynchronousFuture(Result.success([kEnglishHymn, kLocalHymn]));
  }
}
