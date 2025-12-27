import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:nah/data/repositories/hymn/hymn_repository.dart';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';
import 'package:nah/utils/command.dart';
import 'package:nah/utils/result.dart';

class HymnViewModel extends ChangeNotifier {
  final HymnRepository _hymnRepository;

  HymnViewModel({required HymnRepository hymnRepository})
    : _hymnRepository = hymnRepository {
    load = Command1(_load);
    parse = Command1(_parser);
  }

  final _log = Logger("HymnViewModel");

  List<Hymn> _hymns = [];

  List<Hymn> get hymns => List.unmodifiable(_hymns);

  ValueNotifier<Hymn?> selectedHymn = ValueNotifier(null);

  late final Command1<void, int> load;

  late final Command1<void, Hymnal> parse;

  /// Method to load the hymns from database
  /// Depends on the hymnals
  Future<Result> _load(int hymnalId) async {
    try {
      final result = await _hymnRepository.getHymns(hymnalId);
      switch (result) {
        case Success<List<Hymn>>():
          _hymns = result.data;

          _log.fine("Hymn list loaded successfully");
        case Error<List<Hymn>>():
          _log.warning("Failed to load hymns", result.error);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  /// A source reference either be a number only or a number and a code. Not a code only
  SourceRef? _parseSourceRef(Hymn hymn) {
    final text = hymn.details["sourceRef"] as String?;
    if (text == null || text.trim().isEmpty) return null;

    // INTEEPRETING THE REGEXP
    // ^0* => The sourceRef can start with a zero or not. The zero digits will be allowed by the matcher but won't be included in group 1
    // A group is represented by brackets. hence ([0-9]) is group 1 and ([A-Za-z]) is group 2
    // ([0-9]+) => one or more digits
    // \s* => Zero or more white spaces
    // ([A-Za-z]+)? => One or more alphabetical letters. can be zero or one word for sources with a number only
    final m = RegExp(r'^0*([0-9]+)\s*([A-Za-z]+)?').firstMatch(text.trim());
    if (m == null) return null;
    // Parsing the first group. Leading zeros not included
    final num = int.tryParse(m.group(1)!);
    if (num == null) return null;
    // The code can be null
    final code = m.group(2);
    return SourceRef(num, code);
  }

  bool _titlesMatch(String a, String b) {
    final firstA = a.trim().toLowerCase().split(" ").first;

    final firstB = b.trim().toLowerCase().split(" ").first;

    return firstA == firstB;
  }

  Future<Result> _parser(Hymnal hymnal) async {
    try {
      // Ensure hymns for this hymnal are loaded first
      await _load(hymnal.id);

      final sel = selectedHymn.value;

      if (sel == null) {
        _log.warning("No hymn selected");

        // Selected hymn is null, assign the first hymn in the list
        selectedHymn.value = _hymns.first;

        return Result.success(Exception("No hymn selected"));
      }
      // Getting the sourceReference for the current selected hymn
      final selRef = _parseSourceRef(sel);

      Hymn? match;

      // Matching the current selected hymn with the
      for (final h in _hymns) {
        // Getting the sourceReference for the current hymn in the _hymns list
        final hRef = _parseSourceRef(h);

        // 1) exact source ref match (number + code)
        if (selRef != null && hRef != null) {
          if (selRef.number == hRef.number && selRef.code == hRef.code) {
            match = h;
            break;
          }
        }

        // 2) selected is a translation (has source) and candidate is original (id == sel.sourceRef no)
        // The title of the source should be referenced in the translated hymn
        if (selRef != null && hRef == null) {
          final selSourceTitle = sel.details["sourceTitle"] as String?;

          if (h.id == selRef.number &&
              _titlesMatch(h.title, selSourceTitle ?? "")) {
            match = h;
            break;
          }
        }

        // 3) selected is original (no source) and candidate is a translation referencing selected.id
        if (selRef == null && hRef != null) {
          final hSourceTitle = h.details["sourceTitle"] as String?;

          if (hRef.number == sel.id &&
              _titlesMatch(h.title, hSourceTitle ?? "")) {
            match = h;
            break;
          }
        }
      }

      if (match != null) {
        selectedHymn.value = match;
        _log.fine("Match found. Assing it to selected hymn");
        return Result.success(null);
      }
      // if no match found, the selected hymn is the first

      selectedHymn.value = _hymns.first;
      _log.fine("No matching hymn found in ${hymnal.title}");

      return Result.error(
        Exception("No matching hymn found in ${hymnal.title}"),
      );
    } finally {
      notifyListeners();
    }
  }
}

class SourceRef {
  final int number;
  final String? code;
  const SourceRef(this.number, this.code);
}
