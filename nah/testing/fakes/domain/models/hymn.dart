import 'package:nah/data/domain/models/hymn/hymn.dart';

const kLocalHymn = Hymn(
  id: 1,
  title: "HYMN_TITLE",
  details: {"source": "LOCAL_HYMNAL"},
  lyrics: {
    "verses": ["VERSE_1", "VERSE_2"],
    "chorus": "CHORUS",
  },
);
const kEnglishHymn = Hymn(
  id: 1,
  title: "HYMN_TITLE",
  details: {"source": "ENGLISH_HYMNAL"},
  lyrics: {
    "verses": ["VERSE_1", "VERSE_2"],
    "chorus": "CHORUS",
  },
);
