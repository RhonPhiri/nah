import 'package:flutter/material.dart';

enum NavItems {
  hymns,
  collections,
  about;

  Icon get icon {
    return switch (this) {
      hymns => Icon(Icons.queue_music_rounded),
      collections => Icon(Icons.collections_bookmark_rounded),
      about => Icon(Icons.info_rounded),
    };
  }

  String get label {
    return switch (this) {
      hymns => "Hymns",
      collections => "Collections",
      about => "About",
    };
  }
}
