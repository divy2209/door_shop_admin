import 'package:door_shop_admin/screens/home.dart';
import 'package:door_shop_admin/screens/login.dart';
import 'package:door_shop_admin/services/admin_autherization/admin_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AdminID>(context);

    if(userData == null){
      return LoginPage();
    } else{
      return Home();
    }
  }
}