import 'package:nah/domain/models/hymn/hymn.dart';

const kLocalHymn = Hymn(
  id: 1,
  title: "TITLE",
  details: {
    "sourceRef": "1 REF",
    "sourceTitle": "REF",
    "composer": "TEST_COMPOSER",
  },
  lyrics: {
    "verses": ["VERSE_1", "VERSE_2"],
    "chorus": "CHORUS",
  },
);
const kEnglishHymn = Hymn(
  id: 1,
  title: "TITLE",
  details: {
    "sourceRef": "2 REF",
    "sourceTitle": "SELECTED_HYMN",
    "composer": "TEST_COMPOSER",
  },
  lyrics: {
    "verses": ["VERSE_1", "VERSE_2"],
    "chorus": "CHORUS",
  },
);
