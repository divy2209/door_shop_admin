import 'package:door_shop_admin/services/provider_data/login_data.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:door_shop_admin/widgets/login_widgets/background_image.dart';
import 'package:door_shop_admin/widgets/login_widgets/login_animation.dart';
import 'package:door_shop_admin/widgets/login_widgets/login_button.dart';
import 'package:door_shop_admin/widgets/login_widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginData>(
      builder: (context, load, child){
        return load.pageloading ? Loading() : GestureDetector(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LoginForm(),
                            SizedBox(
                              height: 25,
                            ),
                            LoginButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
