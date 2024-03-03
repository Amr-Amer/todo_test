import 'package:flutter/cupertino.dart';

class AppConfigProvider extends ChangeNotifier {

  String appLanguge = 'en' ;

  void changeLanguge (String newLanguge) {
    if (appLanguge == newLanguge ){
      return ;
    }
    appLanguge = newLanguge ;
    notifyListeners();
  }
}