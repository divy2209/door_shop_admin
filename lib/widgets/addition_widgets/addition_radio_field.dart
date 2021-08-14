import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class AdditionRadioField extends StatelessWidget {

  final String form;
  AdditionRadioField({@required this.form});

  final List<String> options = ['Per 250 grams', 'Per 500 grams', 'per Kg'];

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
                  child: Consumer<AdditionData>(
                    builder: (context, addition, child){
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: options.length,
                        itemBuilder: (context, index){
                          return SizedBox(
                            height: 40,
                            child: RadioListTile(
                              groupValue: addition.unit,
                              value: options[index],
                              title: Text(options[index], style: Palette.cropFormInputTextStyle.copyWith(color: Colors.black)),
                              onChanged: (value) {
                                addition.add(value, TextFieldHint.unit);
                              },
                            ),
                          );
                        },
                      );
                    },
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
