import 'dart:io';

import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdationData extends ChangeNotifier{
  String cropIdentifier;
  String cropName;
  int price;
  String unit;
  int quantity;
  int discount;
  String url;
  Crop crop;

  final identifierTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final discountTextController = TextEditingController();

  bool buttonload = false;

  void pickCrop(Crop c){
    crop = c;
    cropIdentifier = crop.identifier;
    cropName = crop.name;
    price = crop.price;
    unit = crop.unit;
    quantity = crop.quantity;
    discount = crop.discount;
    url = crop.url;

    notifyListeners();
  }

  void radioPick(String str){
    unit = str;

    notifyListeners();
  }

  void update(String str, String hint){
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


  void buttonLoad(bool load){
    buttonload = load;
    notifyListeners();
  }

  List<String> generateSearchList(String name){
    int n = name.length;
    List<String> searchList = [];
    for(int i = 1; i<=n; i++){
      String str = name.substring(0,i);
      searchList.add(str);
    }

    return searchList;
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