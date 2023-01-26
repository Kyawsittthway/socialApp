import 'package:flutter/cupertino.dart';

class BottomNavigatorBloc extends ChangeNotifier {
  int? screenIndex;
  BottomNavigatorBloc([int? index]){
    if(index != null){
      screenIndex = index;
    }else{
      screenIndex = 0;
    }

  }


  int? get getCurrentScreenIndex {
    return screenIndex;
  }

  void updateIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
