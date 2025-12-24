import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nah/data/repositories/hymnal/hymnal_repository.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/result.dart';

import '../../domain/models/hymnal.dart';

class FakeHymnalRepository implements HymnalRepository {
  String? hymnal;
  List<Hymnal> hymnals = List.generate(
    5,
    (int index) => kHymnal.copyWith(id: (index + 1)),
  );

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    return SynchronousFuture(Result.success(hymnals));
  }

  @override
  Future<Result<Hymnal?>> getStoredHymnal() async {
    if (hymnal != null) {
      return Result.success(Hymnal.fromJson(jsonDecode(hymnal!)));
    }
    return Result.success(null);
  }

  @override
  Future<Result<void>> storeSelectedHymnal(Hymnal hymnal) async {
    final hymnalJson = jsonEncode(hymnal.toJson());
    this.hymnal = hymnalJson;
    return Result.success(null);
  }
}
