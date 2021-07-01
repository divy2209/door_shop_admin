import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/services/admin_autherization/validate.dart';
import 'package:door_shop_admin/widgets/loading.dart';
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
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Listener(
      onPointerDown: (_){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          //BackgroundImage(image: ''),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'Door Shop Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: Palette.textBoxDeco,
                          child: Center(
                            child: TextFormField(
                              decoration: TextFieldInputDecoration.emailField,
                              onChanged: (value){
                                email = value.trim();
                              },
                              style: Palette.loginTextStyle,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: Palette.textBoxDeco,
                          child: Center(
                            child: TextFormField(
                              decoration: TextFieldInputDecoration.passwordField,
                              onChanged: (value){
                                password = value;
                              },
                              obscureText: true,
                              style: Palette.loginTextStyle,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ),
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
                            String showError = CredentialValidation().loginValidation(email: email, password: password);
                            if(showError == null){
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _authorization.adminLogin(email: email, password: password);
                              if (result == null){
                                setState(() {
                                  loading = false;
                                  print('Error');
                                });
                              }
                              print(email);
                              print(password);
                            } else {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context){
                                  return Container(
                                    height: size.height * 0.3,
                                    width: size.width,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(showError)
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              );
                            }
                          },
                          child: Text(
                            'Admin Access',
                            style: Palette.buttonTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}