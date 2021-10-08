import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../button.dart';

class AddButton extends StatelessWidget {
  static String identifier;
  static String cropName;
  static int price;
  static int quantity;
  static String unit;
  static int discount;

  @override
  Widget build(BuildContext context) {
    final addition = Provider.of<AdditionData>(context, listen: false);
    return Button(
      text: 'Add Crop',
      loading: addition.buttonload,
      click: () async {
        String showError;
        if(addition.imageFile != null){
          identifier = addition.cropIdentifier;
          cropName = addition.cropName;
          price = addition.price;
          quantity = addition.quantity;
          unit = addition.unit;
          discount = addition.discount;

          if(identifier != null && cropName != null && price != null && quantity != null && unit != null && discount != null){

            addition.buttonLoad(true);

            String url = await CropDatabase().upload(addition.imageFile);
            if(url!=null){
              List<String> searchList = AdditionData().generateSearchList(cropName);
              await CropDatabase().addupdateCropData(identifier: identifier, name: cropName, price: price, quantity: quantity, perUnit: unit, discount: discount, url: url, searchList: searchList);
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
        addition.buttonLoad(false);
      },
    );
  }
}
