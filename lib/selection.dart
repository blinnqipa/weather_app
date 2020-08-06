import 'package:flutter/foundation.dart';

class Selection extends ChangeNotifier {
  int selectedItem = 0;

  void changeSelectedItem(int index) {
    selectedItem = index;
    print('selected index: $selectedItem');
    notifyListeners();
  }

  int getSelectedItem() => selectedItem;
}
