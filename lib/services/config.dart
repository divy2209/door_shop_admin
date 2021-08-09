import 'package:shared_preferences/shared_preferences.dart';

class DoorShopAdmin {
  static SharedPreferences sharedPreferences;

  static final String email = 'email';
  static final String password = 'password';

  static final String addIdentifier = 'a_uid';
  static final String addCropName = 'a_name';
  static final String addPrice = 'a_price';
  static final String addQuantity = 'a_quantity';
  static final String addUnit = 'a_unit';
  static final String addDiscount = 'a_discount';

  static final String updateIdentifier = 'u_uid';
  static final String updateCropName = 'u_name';
  static final String updatePrice = 'u_price';
  static final String updateQuantity = 'u_quantity';
  static final String updateUnit = 'u_unit';
  static final String updateDiscount = 'u_discount';
}

class TextFieldHint {
  static final String identifier = 'Crop Identifier';
  static final String cropName = 'Crop Name';
  static final String price = 'Price';
  static final String quantity = 'Quantity';
  static final String unit = 'Unit';
  static final String discount = 'Discount';

  static final String email = 'Email';
  static final String password = 'Password';
}