import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:door_shop_admin/services/provider_data/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/provider_data/updation_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CropImage extends StatelessWidget {
  final File imageFile;
  final String form;
  final String url;
  CropImage({
    @required this.form,
    @required this.imageFile,
    this.url
});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CircleAvatar(
                radius: size.width * 0.20,
                backgroundColor: Colors.grey[400].withOpacity(0.4),
                backgroundImage: imageFile==null ? null : FileImage(imageFile),
                child: imageFile==null && url!=null ? CachedNetworkImage(
                  imageUrl: url,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.black,
                      ),
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            shape:BoxShape.circle,
                            image:DecorationImage(
                                image:imageProvider,
                                fit: BoxFit.cover
                            )
                        ),
                      )
                ) : (imageFile==null ? Icon(
                  FontAwesomeIcons.carrot,
                  color: Palette.primaryColor,
                  size: size.width * 0.1,
                ) : null)
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.11,
          left: size.width * 0.58,
          child: Container(
            height: size.width * 0.15,
            width: size.width * 0.15,
            decoration: BoxDecoration(
                color: Palette.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                if(await Permission.camera.request().isGranted && await Permission.storage.request().isGranted){
                  if(form == FormIdentifier.addition){
                    Provider.of<AdditionData>(context, listen: false).getImage();
                  } else {
                    Provider.of<UpdationData>(context, listen: false).getImage();
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Camera and Gallery Permission'),
                        content: Text(
                            'This app needs camera and gallery access to take pictures for upload crop profile photo'),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                TextButton(
                                  child: Text('Deny'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                Spacer(),
                                TextButton(
                                  child: Text('Settings'),
                                  onPressed: (){
                                    openAppSettings();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                }
              },
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
