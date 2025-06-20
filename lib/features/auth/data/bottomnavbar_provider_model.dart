import 'package:flutter/cupertino.dart';

class BottomnavbarProviderModel extends ChangeNotifier {
  int selectedIndex = 0;
  void updateSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
