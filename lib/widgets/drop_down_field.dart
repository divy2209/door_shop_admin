import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/text_field_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DropDownField extends StatelessWidget {
  static String unit;
  final List<String> unitList = ['per Kg', 'per 250 grams', 'per 500 grams'];

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
          child: DropdownButtonFormField(
            focusColor: Palette.primaryColor,
            style: Palette.cropFormInputTextStyle.copyWith(color: Colors.black),
            decoration: InputDecoration(

              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  FontAwesomeIcons.balanceScale,
                  size: 28,
                  color: Palette.primaryColor,
                ),
              ),
              hintText: TextFieldHint.unit,
              hintStyle: Palette.cropFormInputTextStyle.copyWith(color: Colors.black)
            ),
            value: unit,
            items: unitList.map((value){
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value){
              TextFieldData.save(TextFieldHint.unit, value);
            },
          ),
        ),
      ),
    );
  }
}
