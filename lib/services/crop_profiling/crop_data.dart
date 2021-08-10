import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CropDatabase {
  final String uid;
  CropDatabase({this.uid});

  final CollectionReference crop = FirebaseFirestore.instance.collection('crops');
  dynamic rupee = FontAwesomeIcons.rupeeSign;

  Future addupdateCropData({String identifier, String name, int price, String perUnit, int quantity, int discount, String url}) async {
    return await crop.doc(identifier).set({
      'crop uid': identifier,
      'crop name': name,
      'price $rupee': price,
      'quantity': quantity,
      'pricing and quantity unit': perUnit,
      'discount': discount,
      'image url': url
    });
  }

  Future upload(imageFile) async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(imageFileName);
    await reference.putFile(imageFile);
    String url = await reference.getDownloadURL();
    return url;
  }

  List<CropId>_cropList(QuerySnapshot snap){
    return snap.docs.map((document){
       return CropId(
         uid: document.get('crop uid') ?? '',
       );
      }
    ).toList();
  }

  Crop _cropData(DocumentSnapshot snap){
    return Crop(
      identifier: uid,
      name: snap.get('crop name'),
      price: snap.get('price $rupee'),
      quantity: snap.get('quantity'),
      unit: snap.get('pricing and quantity unit')
    );
  }

  Stream<Crop> get cropData{
    return crop.doc(uid).snapshots().map(_cropData);
  }
}