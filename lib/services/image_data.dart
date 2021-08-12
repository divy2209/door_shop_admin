import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageData extends ChangeNotifier{
  File imageFile;
  final picker = ImagePicker();
  
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }
  void clearImage(){
    imageFile = null;
    notifyListeners();
  }
}