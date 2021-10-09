import 'package:flutter/material.dart';

class HomeData extends ChangeNotifier{
  bool pageloading = false;
  String name;

  void pageLoading(){
    pageloading = !pageloading;
    notifyListeners();
  }

  void search(String value){
    name = value;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}