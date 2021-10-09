import 'dart:ui';

import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/addition_widgets/add_button.dart';
import 'package:door_shop_admin/widgets/addition_widgets/addition_form.dart';
import 'package:door_shop_admin/widgets/crop_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Addition extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addition = Provider.of<AdditionData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Door Shop Admin', style: TextStyle(color: Palette.primaryColor),),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Consumer<AdditionData>(
                  builder: (context, image, child){
                    return CropImage(
                      form: FormIdentifier.addition,
                      imageFile: image.imageFile,
                    );
                  },
                ),
                //CropImage(),
                SizedBox(height: size.height * 0.08),
                Column(
                  children: [
                    AdditionForm(),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.only(left: 45),
                      child: GestureDetector(
                        onTap: (){
                          addition.clear();
                        },
                        child: Text(
                          'Clear Form',
                          style: Palette.cropFormInputTextStyle.copyWith(fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Consumer<AdditionData>(
                      builder: (context, button, child){
                        return AddButton();
                      },
                    ),
                    SizedBox(height: 25,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
