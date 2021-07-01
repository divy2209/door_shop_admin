import 'package:door_shop_admin/services/crop_profiling/crop_data.dart';
import 'package:door_shop_admin/services/crop_profiling/crops.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// TODO: make a search type model and build(make visible) the form after the search
// TODO: reshape the model to whole visibility
// TODO: add the entry deletion button

class CropUpdation extends StatefulWidget {
  @override
  _CropUpdationState createState() => _CropUpdationState();
}

class _CropUpdationState extends State<CropUpdation> {
  static String uid;
  static String unit;

  @override
  Widget build(BuildContext context) {
    final crops = Provider.of<List<CropId>>(context);
    final List<String> cropList = crops.cast<String>().toList();
    Size size = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: DropdownButtonFormField(
                            focusColor: Palette.primaryColor,
                            style: Palette.cropFormInputTextStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 28,
                                  color: Palette.primaryColor,
                                ),
                              ),
                              hintText: 'UID',
                              hintStyle: Palette.cropFormInputTextStyle
                            ),
                            value: uid,
                            items: cropList.map((value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }),
                            onChanged: (value){
                              uid = value;
                              //StreamBuilder<Crop>(
                              //  stream: CropDatabase(uid: uid).cropData,
                              //  builder: void (context, snap) {
                              //    if(snap.hasData){
                              //      Crop crop = snap.data;
                              //    }
                              //  },
                              //);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: TextFormField(
                            decoration: TextFieldInputDecoration.identifierField,
                            style: Palette.cropFormInputTextStyle,
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: TextFormField(
                            decoration: TextFieldInputDecoration.nameField,
                            style: Palette.cropFormInputTextStyle,
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: TextFormField(
                            decoration: TextFieldInputDecoration.priceField,
                            onChanged: (value){

                            },
                            style: Palette.cropFormInputTextStyle,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: TextFormField(
                            decoration: TextFieldInputDecoration.quantityField,
                            onChanged: (value){

                            },
                            style: Palette.cropFormInputTextStyle,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.textBoxDeco,
                        child: Center(
                          child: DropdownButtonFormField(
                            focusColor: Palette.primaryColor,
                            style: Palette.cropFormInputTextStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.balanceScale,
                                  size: 28,
                                  color: Palette.primaryColor,
                                ),
                              ),
                              hintText: 'Unit',
                              hintStyle: Palette.cropFormInputTextStyle
                            ),
                            value: unit,
                            // make a uid list
                            items: [],
                            onChanged: (value){
                              unit = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.8,
                        //padding: EdgeInsets.only(left: 45),
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Text(
                            'Restore',
                            style: Palette.cropFormInputTextStyle.copyWith(fontSize: 15),
                            //textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.1,
                      decoration: Palette.buttonBoxDecoration,
                      child: TextButton(
                        onPressed: () async {

                        },
                        child: Text(
                          'Update Crop',
                          style: Palette.buttonTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          'Back to Home',
                          style: Palette.cropFormInputTextStyle,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.white
                            )
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}