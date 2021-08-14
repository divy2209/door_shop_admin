import 'package:door_shop_admin/services/config.dart';
import 'package:flutter/material.dart';

class LoginData extends ChangeNotifier {
  String email;
  String password;
  bool pageloading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(String str, String hint){
    if(hint == TextFieldHint.email){
      email = str;
    } else if(hint == TextFieldHint.password){
      password = str;
    }
    notifyListeners();
  }

  void clearPass(){
    passwordController.clear();
    password = null;
    notifyListeners();
  }

  void pageLoading(){
    pageloading = !pageloading;
    notifyListeners();
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}