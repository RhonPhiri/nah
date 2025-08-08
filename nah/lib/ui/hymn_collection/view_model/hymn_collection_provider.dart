import 'package:flutter/widgets.dart';
import 'package:nah/data/models/hymn_collection_model.dart';
import 'package:nah/data/repositories/hymn_collection_repo.dart';
import 'package:nah/data/services/nah_services_export.dart';

class HymnCollectionProvider with ChangeNotifier {
  final HymnCollectionRepo _hcRepo;
  HymnCollectionProvider(this._hcRepo) {
    loadHcs();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorSMS = '';
  String? get errorSMS => _errorSMS;

  ///variable to hold various hymn_collections
  final List<HymnCollection> _hcs = []..reversed;

  ///hymn collection getter
  List<HymnCollection> get hcs => List.unmodifiable(_hcs);

  ///method to create a hymnal collection and add it to the hymnCollections & pendingCollections
  Future<void> createHc(HymnCollection hc) async {
    _hcs.add(hc);
    debugPrint("HC PROVIDER: ${hc.title} created and added to HCs list");

    await _hcRepo.cacheHc(hc);
    debugPrint("HC PROVIDER: ${hc.title} cached Successfully");

    notifyListeners();
  }

  ///Method to delete a hymnal collection
  Future<void> deleteHc(HymnCollection hc) async {
    ///if a collection is provided, then remove that collection, otherwise delete the selected collections
    _hcs.remove(hc);
    debugPrint("HC PROVIDER: ${hc.title} removed from Hc List");

    await _hcRepo.deleteHc(hc);

    await loadHcs();

    notifyListeners();
  }

  ///Method to load hymn collections from database
  Future<void> loadHcs() async {
    debugPrint("HC PROVIDER: loading HCs");
    _isLoading = true;
    _errorSMS = null;
    notifyListeners();
    final result = await _hcRepo.fetchHcs();
    switch (result) {
      case Success<List<HymnCollection>> success:
        _hcs
          ..clear()
          ..addAll(success.data);
        _isLoading = false;
        _errorSMS = '';
        debugPrint("HC PROVIDER: HCs loaded Successfully");

        break;
      case Failure<List<HymnCollection>> failure:
        _isLoading = false;
        _errorSMS = failure.error.toString();
        debugPrint("HC PROVIDER: HCs loading unsuccessful: $_errorSMS");
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _hcs.clear();
    debugPrint("HC PROVIDER: Resources disposed successfully");

    super.dispose();
  }
}
