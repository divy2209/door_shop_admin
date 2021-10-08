import 'package:door_shop_admin/services/order_database.dart';
import 'package:door_shop_admin/services/order_model.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final Order order;
  OrderSummary({@required this.order});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Order Summary', style: TextStyle(color: Palette.primaryColor),),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: order.status!=4 ? Palette.primaryColor : Colors.white,
              onTap: () async {
                if(order.status!=4){
                  await OrderDatabase().updateOrderStatus(orderID: order.orderId, status: order.status+1);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 30,
                width: 162,
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.primaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child:Text('Update Order Status', style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Order ID  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text("#" + order.orderId, style: TextStyle(fontSize: 16),),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                      color: Status.statusColor[order.status],
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                  child: Text(Status.status[order.status], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Placed", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    Text(order.dateTime),
                  ],
                ),
                SizedBox(width: size.width*0.08,),
                order.status==4 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivered on", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    Text(order.deliveryDate),
                  ],
                ) : SizedBox(),
                order.status==3 ? Text("Arriving Today", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)) : SizedBox()
              ],
            ),
            SizedBox(height: 35,),
            Text(order.status!=4 ? "Shipped to" : "Delivered to", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            Text(order.customer),
            Text(order.email),
            Text("+91 " + order.contact.toString()),
            SizedBox(height: 10,),
            Text(order.address[0]),
            Text(order.address[1] + ", " + order.address[2]),
            Text(order.address[3]),
            SizedBox(height: 30,),
            Container(
              width: size.width*0.92,
              height: 55*order.crops.length>290 ? 290 : (60*order.crops.length).toDouble(),
              child: Scrollbar(
                thickness: 4,
                controller: _scrollController,
                radius: Radius.circular(5),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: order.crops.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,),
                      child: Row(
                        children: [
                          Container(
                            width: size.width*0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.crops[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    SizedBox(width: size.width*0.02,),
                                    Text(order.units[index] + "  " + '\u{20B9}' + order.prices[index].toString(), style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: size.width*0.14,
                            child: Center(child: Text(order.quantities[index].toString(), style: TextStyle(fontSize: 14),)),
                          ),
                          SizedBox(width: size.width*0.05,),
                          Container(
                              width: 78,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('\u{20B9}' + (order.prices[index]*order.quantities[index]).toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  SizedBox(width: size.width*0.02,)
                                ],
                              )
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12,),
            Divider(color: Colors.grey, thickness: 1,),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Subtotal", style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 5,),
                    Text("Discount", style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 20,),
                    Text("Total")
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text('\u{20B9}' + order.subtotal.toString(), style: TextStyle(color: Colors.grey),),
                        SizedBox(width: 10,)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text('- ' + '\u{20B9}' + (order.subtotal-order.total).toString(), style: TextStyle(color: Colors.grey),),
                        SizedBox(width: 10,)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('\u{20B9}' + order.total.toString()),
                        SizedBox(width: 10,)
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
