import 'package:flutter/material.dart';

enum NavItems {
  hymns,
  collections,
  about;

  Icon icon(int selectedIdx) {
    final isSelected = index == selectedIdx;
    return switch (this) {
      hymns => Icon(Icons.queue_music_rounded),
      collections => Icon(
        isSelected
            ? Icons.collections_bookmark_rounded
            : Icons.collections_bookmark_outlined,
      ),
      about => Icon(isSelected ? Icons.info_rounded : Icons.info_outline),
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
