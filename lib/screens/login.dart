import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/services/admin_autherization/validate.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:door_shop_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                      InputField(
                        isObscure: false,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                        icon: FontAwesomeIcons.envelope,
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      InputField(
                        hintText: 'Password',
                        icon: FontAwesomeIcons.lock,
                        inputAction: TextInputAction.done,
                        isObscure: true,
                        controller: _passwordController,
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
                            email = DoorShopAdmin.sharedPreferences.getString('email');
                            password = DoorShopAdmin.sharedPreferences.getString('password');
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
                                    showError = "Not a Admin Email!";
                                  } else {
                                    showError = "Incorrect password!";
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
                              /*if (result == null){
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
                            }*/
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