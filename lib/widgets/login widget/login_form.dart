import 'package:door_shop_admin/services/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginForm({
    @required this.emailController,
    @required this.passwordController
});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          isObscure: false,
          inputAction: TextInputAction.next,
          inputType: TextInputType.emailAddress,
          icon: FontAwesomeIcons.envelope,
          hintText: TextFieldHint.email,
          controller: widget.emailController,
        ),
        InputField(
          hintText: TextFieldHint.password,
          icon: FontAwesomeIcons.lock,
          inputAction: TextInputAction.done,
          isObscure: true,
          controller: widget.passwordController,
        ),
      ],
    );
  }
}
