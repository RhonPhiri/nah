import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIdx => _selectedIndex;

  void setSelectedIndex(int idx) {
    if (_selectedIndex == idx) return;
    _selectedIndex = idx;
    notifyListeners();
  }
}
