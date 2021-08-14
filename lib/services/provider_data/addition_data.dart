import 'dart:io';

import 'package:door_shop_admin/services/config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdditionData extends ChangeNotifier{
  String cropIdentifier;
  String cropName;
  int price;
  String unit;
  int quantity;
  int discount;

  final identifierTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final discountTextController = TextEditingController();

  bool buttonload = false;

  void add(String str, String hint){
    if(hint == TextFieldHint.identifier){
      cropIdentifier = str;
    } else if(hint == TextFieldHint.cropName){
      cropName = str;
    } else if(hint == TextFieldHint.price){
      price = int.tryParse(str);
    } else if(hint == TextFieldHint.unit){
      unit = str;
    } else if(hint == TextFieldHint.quantity){
      quantity = int.tryParse(str);
    } else if(hint == TextFieldHint.discount){
      discount = int.tryParse(str);
    }
    notifyListeners();
  }

  File imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }

  void clear(){
    cropIdentifier = null;
    cropName = null;
    price = null;
    unit = null;
    quantity = null;
    discount = null;
    imageFile = null;

    identifierTextController.clear();
    nameTextController.clear();
    priceTextController.clear();
    quantityTextController.clear();
    discountTextController.clear();

    notifyListeners();
  }

  void buttonLoad(bool load){
    buttonload = load;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    identifierTextController.dispose();
    nameTextController.dispose();
    priceTextController.dispose();
    quantityTextController.dispose();
    discountTextController.dispose();
  }

}