import 'dart:ui';

import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: replace the dark background
// TODO: make the hint text black and input text too

class CropAddition extends StatefulWidget {
  @override
  _CropAdditionState createState() => _CropAdditionState();
}

class _CropAdditionState extends State<CropAddition> {
  static String identifier;
  static String cropName;
  static int price;
  static int quantity;
  static String unit;

  final List<String> unitList = ['per Kg'];

  final identifierTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  _clear(){
    identifierTextController.clear();
    nameTextController.clear();
    priceTextController.clear();
    quantityTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.primaryColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(0.4),
                              child: Icon(
                                FontAwesomeIcons.carrot,
                                color: Palette.primaryColor,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // TODO: position the arrow accordingly
                        top: size.height * 0.08,
                        left: size.width * 0.55,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                controller: identifierTextController,
                                decoration: TextFieldInputDecoration.identifierField,
                                onChanged: (value){
                                  identifier = value.toLowerCase().trim();
                                },
                                style: Palette.cropFormInputTextStyle,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                controller: nameTextController,
                                decoration: TextFieldInputDecoration.nameField,
                                onChanged: (value){
                                  cropName = value.trim();
                                },
                                style: Palette.cropFormInputTextStyle,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                controller: priceTextController,
                                decoration: TextFieldInputDecoration.priceField,
                                onChanged: (value){
                                  price = int.tryParse(value.trim());
                                },
                                style: Palette.cropFormInputTextStyle,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                controller: quantityTextController,
                                decoration: TextFieldInputDecoration.quantityField,
                                onChanged: (value){
                                  quantity = int.tryParse(value.trim());
                                },
                                style: Palette.cropFormInputTextStyle,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: DropdownButtonFormField(
                                //elevation: 0,
                                focusColor: Palette.primaryColor,
                                //isExpanded: true,
                                style: Palette.cropFormInputTextStyle,
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
                                  hintText: 'Unit',
                                  hintStyle: Palette.cropFormInputTextStyle
                                ),
                                value: unit,
                                items: unitList.map((value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value){
                                  unit = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.only(left: 45),
                          child: GestureDetector(
                            onTap: (){
                              _clear();
                            },
                            child: Text(
                              'Clear Form',
                              style: Palette.cropFormInputTextStyle.copyWith(fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                          )
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
                              if(identifier != null && cropName != null && price != null && quantity != null && unit != null){
                                await CropDatabase().addupdateCropData(identifier: identifier, name: cropName, price: price, quantity: quantity, perUnit: unit);
                                /*Fluttertoast.showToast(
                                  msg: '$cropName Added',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 10,
                                  backgroundColor: Colors.grey[400],
                                  textColor: Palette.primaryColor,
                                  fontSize: 16
                                );*/
                                _clear();
                              }
                            },
                            child: Text(
                              'Add Crop',
                              style: Palette.buttonTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Text(
                              'Back to Home',
                              style: Palette.cropFormInputTextStyle,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.white
                                )
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}