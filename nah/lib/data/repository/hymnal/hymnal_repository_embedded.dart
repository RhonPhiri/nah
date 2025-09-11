import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/data/service/embedded/data_service_embedded.dart';
import 'package:nah/data/service/shared_preferences_service.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/log_levels.dart';
import 'package:nah/utils/result.dart';
import 'dart:developer' show log;

/// [HymnalRepositoryEmbedded] manages all the operation related to hymnals emebedded in the app assets
///
class HymnalRepositoryEmbedded implements HymnalRepository {
  static const _name = "HymnalRepositoryEmbedded";

  final DataServiceEmbedded _dataServiceEmbedded;
  final SharedPrefService _sharedPrefService;

  HymnalRepositoryEmbedded({
    required SharedPrefService sharedPrefService,
    required DataServiceEmbedded dataServiceEmbedded,
  }) : _dataServiceEmbedded = dataServiceEmbedded,
       _sharedPrefService = sharedPrefService;

  @override
  Future<Result<Hymnal>> getStoredHymnal() async {
    final result = await _sharedPrefService.getStoredHymnal();
    if (result is Error<Hymnal>) {
      log(
        "Failure loading stored hymnal language from shared preferences",
        name: _name,
        level: Level.severe,
        error: result.error,
      );
    }
    return result;
  }

  @override
  Future<Result<void>> setHymnal(Hymnal hymnal) async {
    final result = await _sharedPrefService.setHymnal(hymnal);
    if (result is Error<Hymnal>) {
      log(
        "Failure loading stored hymnal language from shared preferences",
        name: _name,
        level: Level.severe,
        error: result.error,
      );
    }
    return result;
  }

  @override
  Future<Result<List<Hymnal>>> getHymnals() async {
    return Future.value(
      Result.success(await _dataServiceEmbedded.getHymnals()),
    );
  }
}
