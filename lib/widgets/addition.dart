import 'dart:ui';

import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/image_data.dart';
import 'package:door_shop_admin/services/text_field_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'radio_field.dart';

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

  bool addload = false;


  _retrieve(){
    identifier = DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addIdentifier);
    cropName = DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addCropName);
    price = int.tryParse(DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addPrice));
    quantity = int.tryParse(DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addQuantity));
    unit = DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addUnit);
    discount = int.tryParse(DoorShopAdmin.sharedPreferences.getString(DoorShopAdmin.addDiscount));
  }

  final _identifierTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _quantityTextController = TextEditingController();
  final _discountTextController = TextEditingController();

  _clear(){
    _discountTextController.clear();
    _identifierTextController.clear();
    _nameTextController.clear();
    _priceTextController.clear();
    _quantityTextController.clear();
    TextFieldData.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final image = Provider.of<ImageData>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          Stack(
            children: [
              Center(
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Consumer<ImageData>(
                      builder: (context, image, child){
                        return CircleAvatar(
                          radius: size.width * 0.20,
                          backgroundColor: Colors.grey[400].withOpacity(0.4),
                          backgroundImage: image.imageFile==null ? null : FileImage(image.imageFile),
                          child: image.imageFile==null ? Icon(
                            FontAwesomeIcons.carrot,
                            color: Palette.primaryColor,
                            size: size.width * 0.1,
                          ) : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.11,
                left: size.width * 0.58,
                child: Container(
                  height: size.width * 0.15,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () async {
                      image.getImage();
                    },
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.08),
          Form(
            child: Column(
              children: [
                InputField(
                  controller: _identifierTextController,
                  hintText: TextFieldHint.identifier,
                  icon: FontAwesomeIcons.user,
                  color: Palette.primaryColor,
                  textColor: Colors.black,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]")),
                ),
                InputField(
                  controller: _nameTextController,
                  hintText: TextFieldHint.cropName,
                  icon: FontAwesomeIcons.carrot,
                  color: Palette.primaryColor,
                  textColor: Colors.black,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                ),
                SizedBox(height: 25),
                InputField(
                  controller: _priceTextController,
                  hintText: TextFieldHint.price,
                  icon: FontAwesomeIcons.rupeeSign,
                  color: Palette.primaryColor,
                  textColor: Colors.black,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                ),
                RadioField(),
                InputField(
                  controller: _quantityTextController,
                  hintText: TextFieldHint.quantity,
                  icon: FontAwesomeIcons.boxOpen,
                  color: Palette.primaryColor,
                  textColor: Colors.black,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),
                SizedBox(height: 25),
                InputField(
                  controller: _discountTextController,
                  hintText: TextFieldHint.discount,
                  icon: FontAwesomeIcons.percentage,
                  color: Palette.primaryColor,
                  textColor: Colors.black,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(left: 45),
                  child: GestureDetector(
                    onTap: (){
                      _clear();
                      image.clearImage();
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
                      if(image.imageFile != null){
                        if(_identifierTextController.text.isNotEmpty && _nameTextController.text.isNotEmpty && _priceTextController.text.isNotEmpty && _quantityTextController.text.isNotEmpty && _discountTextController.text.isNotEmpty){
                          _retrieve();
                          if(identifier.isNotEmpty && cropName.isNotEmpty && price != null && quantity != null && unit.isNotEmpty && discount != null){
                            setState(() {
                              addload = true;
                            });
                            String url = await CropDatabase().upload(image.imageFile);
                            if(url!=null){
                              await CropDatabase().addupdateCropData(identifier: identifier, name: cropName, price: price, quantity: quantity, perUnit: unit, discount: discount, url: url);
                              showError = '$identifier added in the database';
                              _clear();
                              image.clearImage();
                            } else {
                              showError = 'Image not uploaded';
                            }
                          } else {
                            showError = 'Fields cannot be left empty';
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
          ),
        ],
      ),
    );
  }
}
