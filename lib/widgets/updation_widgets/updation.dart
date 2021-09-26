import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/provider_data/updation_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/crop_image.dart';
import 'package:door_shop_admin/widgets/updation_widgets/update_button.dart';
import 'package:door_shop_admin/widgets/updation_widgets/updation_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Updation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final updation = Provider.of<UpdationData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Door Shop Admin', style: TextStyle(color: Palette.primaryColor),),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height*0.03),
                Consumer<UpdationData>(
                  builder: (context, image, child){
                    return Hero(
                      tag: updation.crop,
                      transitionOnUserGestures: true,
                      child: Material(
                        type: MaterialType.transparency,
                        child: CropImage(
                          form: FormIdentifier.updation,
                          imageFile: image.imageFile,
                          url: updation.url,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.08,),
                FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 950)),
                  builder: (c,s) => s.connectionState==ConnectionState.done
                    ? Column(
                    children: [
                      UpdationForm(),
                      SizedBox(height: 40),
                      Consumer<UpdationData>(
                        builder: (context, button, child){
                          return UpdateButton();
                        },
                      ),
                      SizedBox(height: 25,)
                    ],
                  )
                      : Container(
                    height: 495,
                    color: Colors.transparent,
                  )
                ),
                /*Column(
                  children: [
                    UpdationForm(),
                    SizedBox(height: 40),
                    Consumer<UpdationData>(
                      builder: (context, button, child){
                        return UpdateButton();
                      },
                    ),
                    SizedBox(height: 25,)
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
