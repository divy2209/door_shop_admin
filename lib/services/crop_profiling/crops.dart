class CropId {
  final String uid;
  CropId({this.uid});
}

class Crop {
  final String identifier;
  final String name;
  final int price;
  final int quantity;
  final String unit;

  Crop({this.identifier, this.name, this.price, this.quantity, this.unit});
}