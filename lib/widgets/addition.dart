import 'dart:ui';

import 'package:door_shop_admin/services/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/addition%20widgets/addition_form.dart';
import 'package:door_shop_admin/widgets/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


class Addition extends StatefulWidget {


  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {

  static String identifier;
  static String cropName;
  static int price;
  static int quantity;
  static String unit;
  static int discount;

  final String form = FormIdentifier.addition;

  bool addload = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addition = Provider.of<AdditionData>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          CropImage(),
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
              Container(
                height: size.height * 0.08,
                width: size.width * 0.8,
                decoration: Palette.buttonBoxDecoration,
                child: TextButton(
                  onPressed: () async {
                    String showError;
                    if(addition.imageFile != null){
                      identifier = addition.cropIdentifier;
                      cropName = addition.cropName;
                      price = addition.price;
                      quantity = addition.quantity;
                      unit = addition.unit;
                      discount = addition.discount;

                      if(identifier.isNotEmpty && cropName.isNotEmpty && price != null && quantity != null && unit.isNotEmpty && discount != null){
                        setState(() {
                          addload = true;
                        });
                        String url = await CropDatabase().upload(addition.imageFile);
                        if(url!=null){
                          await CropDatabase().addupdateCropData(identifier: identifier, name: cropName, price: price, quantity: quantity, perUnit: unit, discount: discount, url: url);
                          showError = '$identifier added in the database';
                          addition.clear();
                        } else {
                          showError = 'Image not uploaded';
                        }
                      } else {
                        showError = 'Fields cannot be left empty';
                      }
                    } else {
                      showError = 'Select an image for the crop';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(showError),
                        backgroundColor: Palette.primaryColor.withOpacity(0.4),
                        duration: Duration(seconds: 5),
                      )
                    );
                    setState(() {
                      addload = false;
                    });
                  },
                  child: addload ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: 30,
                  ) : Text(
                    'Add Crop',
                    style: Palette.buttonTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 25,)
            ],
          ),
        ],
      ),
    );
  }
}
