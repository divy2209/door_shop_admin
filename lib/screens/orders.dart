import 'package:door_shop_admin/services/order_database.dart';
import 'package:door_shop_admin/services/order_model.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/order_widgets/orderlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Orders', style: TextStyle(color: Palette.primaryColor),),
          centerTitle: true,
        ),
        body: StreamProvider<List<Order>>.value(
          value: OrderDatabase().ordersData,
          initialData: null,
          child: OrderList(),
        )
    );
  }
}
