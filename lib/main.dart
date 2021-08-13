import 'package:door_shop_admin/services/admin_autherization/admin_user.dart';
import 'package:door_shop_admin/services/admin_autherization/authorization.dart';
import 'package:door_shop_admin/services/admin_autherization/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// TODO: Autocorrect functionality
// TODO: Check on the flash screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // TODO: Check the changes by SystemChrome class (Transparent status bar)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  // TODO: If up and down both required and what's the difference
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AdminID>.value(
      value: AuthorizationService().admin,
      initialData: null,
      child: MaterialApp(
        title: "Door Shop Admin",
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),      
    );
  }
}