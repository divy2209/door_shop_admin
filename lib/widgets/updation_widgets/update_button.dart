import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/provider_data/updation_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../button.dart';

class UpdateButton extends StatelessWidget {
  static String identifier;
  static String cropName;
  static int price;
  static int quantity;
  static String unit;
  static int discount;


  @override
  Widget build(BuildContext context) {
    final updation = Provider.of<UpdationData>(context, listen: false);
    return Button(
      text: 'Update Crop',
      loading: updation.buttonload,
      click: () async {
        String showError;
        if(updation.imageFile != null || updation.url!=null){
          identifier = updation.cropIdentifier;
          cropName = updation.cropName;
          price = updation.price;
          quantity = updation.quantity;
          unit = updation.unit;
          discount = updation.discount;

          if(identifier != null && cropName != null && price != null && quantity != null && unit != null && discount != null){

            updation.buttonLoad(true);

            String url;
            if(updation.imageFile != null) url = await CropDatabase().upload(updation.imageFile);
            else url = updation.url;

            if(url!=null){
              List<String> searchList = UpdationData().generateSearchList(cropName);
              await CropDatabase().addupdateCropData(identifier: identifier, name: cropName, price: price, quantity: quantity, perUnit: unit, discount: discount, url: url, searchList: searchList);
              showError = '$identifier updated in the database';
              updation.imageFile = null;
              Navigator.pop(context);
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
        updation.buttonLoad(false);
      },
    );
  }
}
