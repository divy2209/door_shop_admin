import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/services/admin_autherization/validate.dart';
import 'package:door_shop_admin/widgets/login%20widget/background_image.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:door_shop_admin/widgets/login%20widget/login_animation.dart';
import 'package:door_shop_admin/widgets/login%20widget/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: Door shop admin text not centered
// TODO: add a sizedbox at the end
// TODO: add validator for login credentials

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final AuthorizationService _authorization = AuthorizationService();

  static String email;
  static String password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          BackgroundImage(image: 'assets/login.jpg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 150,),
                  LoginAnimatedText(),
                  SizedBox(height: 100,),
                  Center(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          LoginForm(
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.buttonBoxDecoration,
                            child: TextButton(
                              onPressed: () async {
                                email = DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.email);
                                password = DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.password);
                                String showError = CredentialValidation().loginValidation(email: email, password: password);
                                if(showError == null){
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _authorization.adminLogin(email: email, password: password);
                                  if (result == 505284406 || result == 185768934){
                                    setState(() {
                                      loading = false;
                                      if(result == 505284406){
                                        showError = "Not an Admin Email!";
                                      } else {
                                        showError = "Incorrect password!";
                                        _passwordController.clear();
                                      }
                                    });
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
                              child: Text(
                                'Admin Access',
                                style: Palette.buttonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}