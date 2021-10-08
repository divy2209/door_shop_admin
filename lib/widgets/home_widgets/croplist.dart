import 'package:cached_network_image/cached_network_image.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:door_shop_admin/services/provider_data/updation_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/updation_widgets/updation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final crops = Provider.of<List<Crop>>(context);
    final updation = Provider.of<UpdationData>(context, listen: false);

    return crops==null ? Center(child: CircularProgressIndicator()) : ListView.builder(
      itemCount: crops.length,
      itemBuilder: (context, index){
        final Crop crop = crops[index];
        return Card(
          elevation: 5,
          color: Colors.white,
          margin: EdgeInsets.all(15),
          child: Container(
            height: 110,
            margin: EdgeInsets.only(left: 10),
            child: InkWell(
              splashColor: Palette.primaryColor,
              onTap: (){
                updation.pickCrop(crop);
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      reverseTransitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_,__,___) => Updation()
                    )
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: crop,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40,
                        child: CachedNetworkImage(
                          imageUrl: crop.url,
                          progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.black,),
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape:BoxShape.circle,
                                  image:DecorationImage(
                                    image:imageProvider,
                                    fit: BoxFit.cover
                                  )
                                ),
                              )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(crop.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(crop.identifier, style: TextStyle(fontSize: 14),),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(crop.unit + " (" + crop.quantity.toString() + ")", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),),
                      Row(
                        children: [
                          Text("MRP: "),
                          crop.discount==0 ? Text('\u{20B9}' + crop.price.toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),) :
                              Row(
                                children: [
                                  Text('\u{20B9}' + crop.price.toString(), style: TextStyle(decoration: TextDecoration.lineThrough, fontStyle: FontStyle.italic, fontSize: 14),),
                                  Text(" " + '\u{20B9}' + (crop.price-crop.price*crop.discount/100).round().toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),)
                                ],
                              ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
