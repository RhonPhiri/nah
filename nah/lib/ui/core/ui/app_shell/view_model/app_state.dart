import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  /// Variable holding the current index based on the Navigation Tab tapped
  int _selectedIdx;

  AppState() : _selectedIdx = 0;

  int get selectedIdx => _selectedIdx;

  void updateSelectedIdx(int idx) {
    if (_selectedIdx != idx) {
      _selectedIdx = idx;
      notifyListeners();
    }
  }
}
