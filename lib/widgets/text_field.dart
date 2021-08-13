import 'package:door_shop_admin/services/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/login_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isObscure;
  final IconData icon;
  final String hintText;
  final FilteringTextInputFormatter inputFormat;
  final Color color;
  final Color textColor;
  final int textLength;
  final String form;

  const InputField({
    Key key,
    this.isObscure,
    @required this.inputAction,
    this.inputType,
    @required this.controller,
    @required this.icon,
    @required this.hintText,
    this.inputFormat,
    this.color,
    this.textColor,
    this.textLength,
    @required this.form
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: Palette.textBoxDeco,
        child: Center(
            child: TextFormField(
              controller: controller,
              cursorColor: Palette.primaryColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      icon,
                      size: 28,
                      color: color ?? Colors.white,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: Palette.loginTextStyle.copyWith(color: textColor ?? Colors.white)
              ),
              onChanged: (value){
                if(form == FormIdentifier.login){
                  Provider.of<LoginData>(context, listen: false).login(value, hintText);
                } else if(form == FormIdentifier.addition){
                  Provider.of<AdditionData>(context, listen: false).add(value, hintText);
                }
              },
              style: Palette.loginTextStyle.copyWith(color: textColor ?? Colors.white),
              obscureText: isObscure ?? false,
              keyboardType: inputType,
              textInputAction: inputAction,
              inputFormatters: [inputFormat ?? FilteringTextInputFormatter.singleLineFormatter, LengthLimitingTextInputFormatter(textLength ?? 500)],
            )
        ),
      ),
    );
  }
}