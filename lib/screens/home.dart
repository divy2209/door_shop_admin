import 'package:door_shop_admin/screens/addition.dart';
import 'package:door_shop_admin/screens/updation.dart';
import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/loading.dart';
import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text('Door Shop Admin'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await _authorization.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: Palette.buttonBoxDecoration,
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CropAddition())
                  );
                },
                child: Text(
                  'Add New Crop',
                  style: Palette.buttonTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: Palette.buttonBoxDecoration,
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CropUpdation())
                  );
                },
                child: Text(
                  'Update Crop',
                  style: Palette.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}