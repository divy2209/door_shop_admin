import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CropDatabase {
  final String uid;
  CropDatabase({this.uid});

  final CollectionReference crop = FirebaseFirestore.instance.collection('crops');
  dynamic rupee = FontAwesomeIcons.rupeeSign;

  Future addupdateCropData({String identifier, String name, int price, String perUnit, int quantity, int discount, String url, List<String> searchList}) async {
    return await crop.doc(identifier).set({
      'crop uid': identifier,
      'crop name': name,
      'price $rupee': price,
      'quantity': quantity,
      'pricing and quantity unit': perUnit,
      'discount': discount,
      'image url': url,
      'search list': searchList
    });
  }

  Future upload(imageFile) async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(imageFileName);
    await reference.putFile(imageFile);
    String url = await reference.getDownloadURL();
    return url;
  }

  List<Crop> _cropsDataList(QuerySnapshot snap){
    return snap.docs.map((doc){
      return Crop(
        identifier: doc.get('crop uid'),
        name: doc.get('crop name'),
        price: doc.get('price $rupee'),
        quantity: doc.get('quantity'),
        unit: doc.get('pricing and quantity unit'),
        discount: doc.get('discount'),
        url: doc.get('image url'),
      );
    }).toList();
  }

  Stream<List<Crop>>get cropsData{
    return crop.snapshots().map(_cropsDataList);
  }
}