import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  /// Variable holding the current index based on the Navigation Tab tapped
  int _selectedIdx;

  bool _show404 = true;

  AppState() : _selectedIdx = 0;

  int get selectedIdx => _selectedIdx;

  bool get show404 => _show404;

  void updateSelectedIdx(int idx) {
    if (_selectedIdx != idx) {
      _selectedIdx = idx;
      notifyListeners();
    }
  }

  void updateShow404(bool show404) {
    if (_show404 != show404) {
      _show404 = show404;
      notifyListeners();
    }
  }
}
