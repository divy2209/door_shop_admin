import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'order_model.dart';

class OrderDatabase{
  final CollectionReference order = FirebaseFirestore.instance.collection('orders');

  Future updateOrderStatus({String orderID, int status}) async{
    String deliveryDate;
    if(status==4) deliveryDate = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());
    return await order.doc(orderID).update({
      'delivery date': deliveryDate,
      'status': status,
    });
  }

  List<Order> _orderList(QuerySnapshot snap){
    return snap.docs.map((doc){
      return Order(
          orderId: doc.get('order uid'),
          customer: doc.get('customer name'),
          crops: doc.get('crop list'),
          prices: doc.get('price list'),
          discounts: doc.get('discount list'),
          quantities: doc.get('quantity list'),
          units: doc.get('unit list'),
          subtotal: doc.get('subtotal'),
          total: doc.get('total bill'),
          dateTime: doc.get('date & time'),
          address: doc.get('delivery address'),
          status: doc.get('status'),
          deliveryDate: doc.get('delivery date'),
          email: doc.get('email'),
          contact: doc.get('phone number')
      );
    }).toList();
  }

  Stream<List<Order>> get ordersData{
    return order.orderBy('order uid', descending: true).snapshots().map(_orderList);
  }
}