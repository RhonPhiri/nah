import 'package:nah/data/domain/models/hymn/hymn.dart';

abstract interface class DataService {
  Future<List<Hymn>> getHymns(String hymnalLanguage);
}
