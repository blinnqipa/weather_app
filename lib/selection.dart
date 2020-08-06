import 'package:flutter/foundation.dart';

class Selection extends ChangeNotifier {
  int selectedItem = 0;

  void changeSelectedItem(int index) {
    selectedItem = index;
    notifyListeners();
  }

  int getSelectedItem() => selectedItem;
}
