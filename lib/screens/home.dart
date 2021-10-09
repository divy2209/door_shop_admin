import 'package:door_shop_admin/screens/orders.dart';
import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/provider_data/home_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/home_widgets/croplist.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'add_crop.dart';

// TODO: make a add page for vegetables and update page to update the pricing


class Home extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeData>(
      builder: (context, home, child){
        return StreamProvider<List<Crop>>.value(
          value: CropDatabase(search: home.name).cropsData,
          initialData: null,
          child: home.pageloading ? Loading() : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                currentFocus.focusedChild.unfocus();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text('Door Shop Admin', style: TextStyle(color: Palette.primaryColor),),
                centerTitle: true,
                actions: [
                  PopupMenuButton<int>(
                    icon: Icon(FontAwesomeIcons.ellipsisV, color: Palette.primaryColor, size: 18,),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.shoppingBag,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text('Orders')
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text('Logout')
                          ],
                        ),
                      )
                    ],
                    onSelected: (item) async {
                      if(item == 0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>Orders())
                        );
                      } else {
                        home.pageLoading();
                        await _authorization.signOut();
                      }
                    },
                  ),
                ],
              ),
              body: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.primaryColor),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))],
                        cursorColor: Palette.primaryColor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Palette.primaryColor,),
                            hintText: "Search..."
                        ),
                        onChanged: (value){
                          home.search(value);
                        },
                      ),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    CropList(),
                    Positioned(
                      right: 40,
                      bottom: 60,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddCropScreen())
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey[300].withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: Icon(FontAwesomeIcons.plus, color: Palette.primaryColor, size: 25,),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        );
      },
    );
  }
}
