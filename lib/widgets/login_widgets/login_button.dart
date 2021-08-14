import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/admin_autherization/validate.dart';
import 'package:door_shop_admin/services/provider_data/login_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../button.dart';

class LoginButton extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  static String email;
  static String password;

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginData>(context, listen: false);
    return Button(
      text: 'Admin Access',
      click: () async {
        email = login.email;
        password = login.password;
        String showError = CredentialValidation().loginValidation(email: email, password: password);
        if(showError == null){
          login.pageLoading();
          dynamic result = await _authorization.adminLogin(email: email, password: password);
          if (result == 505284406 || result == 185768934){
            login.pageLoading();
            if(result == 505284406){
              showError = "Not an Admin Email!";
            } else {
              showError = "Incorrect password!";

              login.clearPass();
            }
          }
        }
        if(showError != null){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(showError),
                backgroundColor: Palette.primaryColor.withOpacity(0.4),
                duration: Duration(seconds: 5),
              )
          );
        }
      },
    );
  }
}
