import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/image_data.dart';
import 'package:door_shop_admin/services/text_field_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/addition.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:door_shop_admin/widgets/updation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: make a add page for vegetables and update page to update the pricing

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  final AuthorizationService _authorization = AuthorizationService();

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ImageData>(
      create: (context) => ImageData(),
      child: loading ? Loading() : GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.primaryColor,
            elevation: 0,
            title: Text('Door Shop Admin'),
            actions: [
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
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
                  Future.delayed(const Duration(seconds: 1),() async {
                    if(item == 0){
                      setState(() {
                        loading = true;
                      });
                      await _authorization.signOut();
                      TextFieldData.clear();
                    }
                  });
                },
              ),
            ],
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: 'Addition',
                    ),
                    Tab(
                      text: 'Updation',
                    )
                  ],
                  indicatorColor: Palette.primaryColor,
                  labelColor: Palette.primaryColor,
                  unselectedLabelColor: Palette.primaryColor.withOpacity(0.5),
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Addition(),
                      Updation()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}