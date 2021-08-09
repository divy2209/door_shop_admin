import 'package:door_shop_admin/services/config.dart';

class TextFieldData {
  static void save(String hintText, dynamic value){
    if(hintText == TextFieldHint.email){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.email, value.trim());
    } else if(hintText == TextFieldHint.password){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.password, value);
    } else if(hintText == TextFieldHint.identifier){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addIdentifier, value.trim());
    } else if(hintText == TextFieldHint.cropName){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addCropName, value.trim());
    } else if(hintText == TextFieldHint.price){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addPrice, value.trim());
    } else if(hintText == TextFieldHint.quantity){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addQuantity, value.trim());
    } else if(hintText == TextFieldHint.unit){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addUnit, value.trim());
    } else if(hintText == TextFieldHint.discount){
      DoorShopAdmin.sharedPreferences.setString(DoorShopAdmin.addDiscount, value.trim());
    }
  }

  static void clear(){
    DoorShopAdmin.sharedPreferences.clear();
  }
}