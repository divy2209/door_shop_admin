import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

mixin Palette{
  static Color primaryColor = Vx.hexToColor("#2e8b57");

  static BoxDecoration textBoxDeco = BoxDecoration(
    color: Colors.grey[500].withOpacity(0.4),
    borderRadius: BorderRadius.circular(16)
  );

  static TextStyle loginTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    height: 1.5
  );
  static TextStyle cropFormInputTextStyle = TextStyle(
    fontSize: 22,
    color: primaryColor,
    height: 1.5
  );
  static BoxDecoration buttonBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: primaryColor
  );
  
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    height: 1.5,
    fontWeight: FontWeight.bold
  );

}

mixin TextFieldInputDecoration{

  static InputDecoration passwordField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.lock,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Password',
    hintStyle: Palette.loginTextStyle
  );

  static InputDecoration emailField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.envelope,
        size: 28,
        color: Colors.white,
      ),
    ),
    hintText: 'Email',
    hintStyle: Palette.loginTextStyle
  );

  static InputDecoration identifierField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.user,
        size: 28,
        color: Palette.primaryColor,
      ),
    ),
    hintText: 'Crop Identifier',
    hintStyle: Palette.cropFormInputTextStyle
  );

  static InputDecoration nameField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.carrot,
        size: 28,
        color: Palette.primaryColor,
      ),
    ),
    hintText: 'Crop Name',
    hintStyle: Palette.cropFormInputTextStyle
  );

  static InputDecoration priceField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.rupeeSign,
        size: 28,
        color: Palette.primaryColor,
      ),
    ),
    hintText: 'Price',
    hintStyle: Palette.cropFormInputTextStyle
  );

  static InputDecoration quantityField = InputDecoration(
    border: InputBorder.none,
    prefixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        FontAwesomeIcons.boxOpen,
        size: 28,
        color: Palette.primaryColor,
      ),
    ),
    hintText: 'Quantity',
    hintStyle: Palette.cropFormInputTextStyle
  );

}

mixin Status{
  static final List<String> status = ['Order Placed', 'Processing', 'In Transit', 'Out for Delivery', 'Delivered'];
  static final List<Color> statusColor = [Colors.deepOrangeAccent.shade100, Colors.deepOrangeAccent.shade200, Colors.deepOrangeAccent.shade200, Colors.green.shade300, Colors.green];
}