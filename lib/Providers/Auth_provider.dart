import 'package:flutter/widgets.dart';
import 'package:todo_test/Model/user.dart';

class AuthProviders extends ChangeNotifier {

  MyUser? curentUser ;

  void updateUser (MyUser? newUser){
    curentUser = newUser ;
    notifyListeners();
  }

}