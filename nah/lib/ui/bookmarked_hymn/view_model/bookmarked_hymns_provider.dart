///provider to manage the list of hymns that have been added to a certain collection
///This provider is intended to be called when the user is opening the bookmarked hymns
///page.
///It has been created so that when a collection hymnList changes, these changes
///are refrected in this provider via the _bookmarkedHymns field
library;

import 'package:flutter/material.dart';
import 'package:nah/data/models/bookmark_model.dart';
import 'package:nah/data/models/hymn_collection_model.dart';
import 'package:nah/data/models/hymn_model.dart';
import 'package:nah/data/repositories/bookmark_repository.dart';
import 'package:nah/data/repositories/hymn_repository.dart';
import 'package:nah/data/services/nah_services_export.dart';

class BookmarkedHymnsProvider with ChangeNotifier {
  final HymnRepository _hymnRepo;
  final BookmarkRepository _bmRepo;
  BookmarkedHymnsProvider(this._hymnRepo, this._bmRepo) {
    loadBms();
  }

  ///Variable to show if the bookmarked hymns in this collection are being fetched from database
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///variable to hold the error sms
  String? _errorSms;
  String? get errorSms => _errorSms;

  ///variable to hold the current bh being viewed
  List<Hymn> _bmHymns = [];
  List<Hymn> get bmHymns => List.unmodifiable(_bmHymns);

  ///field to store the list of bookmarkes
  final List<Bookmark> _bms = [];
  List<Bookmark> get bms => List.unmodifiable(_bms);

  ///field to store the current selected collection
  HymnCollection _hc = HymnCollection(title: '', description: '');
  HymnCollection get hc => _hc;

  ///method to asign the collection when clicked
  ///Also called to add the list of bookmarkedhymns
  void updateCollection({HymnCollection? collection}) {
    if (collection != null) {
      _hc = collection;
    }
  }

  ///Method to toggle the checkBox of a particular hymnCollection
  void toggleHcCheckBox({
    required bool newValue,
    required Bookmark newBm,
  }) async {
    switch (newValue) {
      case true:
        _bms.add(newBm);
        debugPrint("BM PROVIDER: ${newBm.title} added to bm list");

        await _bmRepo.cacheBm(newBm);
        debugPrint("BM PROVIDER: ${newBm.title} cached successfully");
        break;
      case false:
        _bms.remove(newBm);
        debugPrint("BM PROVIDER: ${newBm.title} removed from bm list");

        await _bmRepo.deleteBm(newBm);
        debugPrint(
          "BM PROVIDER: ${newBm.title} deleted from database successfully",
        );
        break;
    }
    notifyListeners();
  }

  ///Method to fetch bookmarks
  Future<void> loadBms() async {
    debugPrint("BM PROVIDER: Loading all bookmarks");
    _isLoading = true;
    notifyListeners();
    final result = await _bmRepo.fetchBm();
    switch (result) {
      case Success<List<Bookmark>> success:
        _bms
          ..clear()
          ..addAll(success.data);
        debugPrint("BM PROVIDER: BMs successfully fetched from DB");
        _isLoading = false;
        break;
      case Failure<List<Bookmark>> failure:
        debugPrint(
          "BM PROVIDER: Failed to load bookmarks from database: ${failure.error.toString()}",
        );

        notifyListeners();
    }
  }

  ///Method to load hymns from the database that are associated with a particular collection
  ///Method will be called in the hymn collection screen when a collection is pressed.
  ///This will filter bms from the bm list and for each bm, fetch a respective hymn and add them to the [_bhHymns] and make them available to the bmScreen
  Future<void> loadBmHymnsForCollection(HymnCollection collection) async {
    _isLoading = true;
    notifyListeners();
    //filter bookmarks for this collection
    final collectionBms =
        _bms.where((b) => b.hcTitle == collection.title.toLowerCase()).toList();

    //fetch hymns from DB for each bookmark
    final hymns = <Hymn>[];

    for (final bm in collectionBms) {
      final result = await _hymnRepo.getBookmarkedHymns(bm.id, bm.language);
      if (result is Success<List<Hymn>>) {
        hymns.addAll(result.data);
        debugPrint(
          "BM PROVIDER: ${hymns.length} BM Hymns fetched from DB and loaded in BM Provider successfully",
        );
      } else if (result is Failure<List<Hymn>>) {
        debugPrint(
          "BM PROVIDER: Failed to fetch BM hymns from DB and load in BM Provider: ${result.error}",
        );
      }
    }
    _bmHymns = hymns;
    _isLoading = false;
    notifyListeners();
    debugPrint("Bh data available...");
  }

  @override
  void dispose() {
    _bmHymns.clear();
    _bms.clear();
    debugPrint("BM PROVIDER: Resources disposed successfully");
    super.dispose();
  }
}
