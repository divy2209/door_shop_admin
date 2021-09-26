import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/widgets/addition_widgets/addition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCropScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdditionData(),
      child: Addition(),
    );
  }
}
