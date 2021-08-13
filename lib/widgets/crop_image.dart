import 'dart:ui';

import 'package:door_shop_admin/services/addition_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CropImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Consumer<AdditionData>(
                builder: (context, image, child){
                  return CircleAvatar(
                    radius: size.width * 0.20,
                    backgroundColor: Colors.grey[400].withOpacity(0.4),
                    backgroundImage: image.imageFile==null ? null : FileImage(image.imageFile),
                    child: image.imageFile==null ? Icon(
                      FontAwesomeIcons.carrot,
                      color: Palette.primaryColor,
                      size: size.width * 0.1,
                    ) : null,
                  );
                },
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
                Provider.of<AdditionData>(context, listen: false).getImage();
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
