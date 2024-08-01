import 'package:flutter/material.dart';

class RootController extends ChangeNotifier {
  int _selectedItem = 0;

  int get getSelectedItem {
    return _selectedItem;
  }

  setSelectedItem(int selectedItem) {
    _selectedItem = selectedItem;
    notifyListeners();
  }
}
