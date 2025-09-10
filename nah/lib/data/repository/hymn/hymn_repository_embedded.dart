import 'package:nah/data/repository/hymn/hymn_repository.dart';
import 'package:nah/data/service/embedded/data_service_embedded.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/utils/result.dart';

class HymnRepositoryEmbedded extends HymnRepository {
  final DataServiceEmbedded _dataServiceEmbedded;

  HymnRepositoryEmbedded({required DataServiceEmbedded dataServiceEmbedded})
    : _dataServiceEmbedded = dataServiceEmbedded;

  @override
  Future<Result<List<Hymn>>> getHymns(String language) async {
    return Future.value(
      Result.success(await _dataServiceEmbedded.getHymns(language)),
    );
  }
}
