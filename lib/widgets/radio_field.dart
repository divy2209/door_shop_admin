import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/text_field_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadioField extends StatefulWidget {

  @override
  _RadioFieldState createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  static String unit;

  _save(value){
    unit = value;
    TextFieldData.save(TextFieldHint.unit, value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.165,
        width: size.width * 0.8,
        decoration: Palette.textBoxDeco,
        child: Center(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(18),
                child: Icon(
                  FontAwesomeIcons.balanceScale,
                  size: 28,
                  color: Palette.primaryColor,
                ),
              ),
              Container(
                width: size.width * 0.6,
                child: Theme(
                  data: ThemeData(
                    toggleableActiveColor: Palette.primaryColor,
                    splashColor: Colors.transparent
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: RadioListTile(
                          groupValue: unit,
                          title: Text('Per 250 grams', style: Palette.cropFormInputTextStyle.copyWith(color: Colors.black)),
                          value: 'per 250 grams',
                          onChanged: (value) {
                            setState(() {
                              _save(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: RadioListTile(
                          groupValue: unit,
                          title: Text('Per 500 grams', style: Palette.cropFormInputTextStyle.copyWith(color: Colors.black)),
                          value: 'per 500 grams',
                          onChanged: (value) {
                            setState(() {
                              _save(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: RadioListTile(
                          groupValue: unit,
                          title: Text('Per Kg', style: Palette.cropFormInputTextStyle.copyWith(color: Colors.black)),
                          value: 'per Kg',
                          onChanged: (value) {
                            setState(() {
                              _save(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
