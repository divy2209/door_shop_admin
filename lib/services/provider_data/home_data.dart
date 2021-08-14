import 'package:flutter/material.dart';

class HomeData extends ChangeNotifier{
  bool pageloading = false;

  void pageLoading(){
    pageloading = !pageloading;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}