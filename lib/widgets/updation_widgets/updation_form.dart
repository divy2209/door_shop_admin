import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/provider_data/updation_data.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:door_shop_admin/widgets/updation_widgets/updation_radio_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../text_field.dart';

class UpdationForm extends StatelessWidget {
  final String form = FormIdentifier.updation;

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdationData>(
      builder: (context, updation, child){
        return Form(
          child: Column(
            children: [

              InputField(
                form: form,
                disable: true,
                controller: updation.identifierTextController,
                text: updation.cropIdentifier,
                hintText: TextFieldHint.identifier,
                icon: FontAwesomeIcons.user,
                color: Palette.primaryColor,
                textColor: Colors.black,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
                inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]")),
              ),
              InputField(
                form: form,
                controller: updation.nameTextController,
                text: updation.cropName,
                hintText: TextFieldHint.cropName,
                icon: FontAwesomeIcons.carrot,
                color: Palette.primaryColor,
                textColor: Colors.black,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
              ),
              SizedBox(height: 25),
              InputField(
                form: form,
                controller: updation.priceTextController,
                hintText: TextFieldHint.price,
                text: updation.price.toString(),
                icon: FontAwesomeIcons.rupeeSign,
                color: Palette.primaryColor,
                textColor: Colors.black,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                textLength: 3,
              ),
              UpdationRadioField(
                form: form,
              ),
              InputField(
                form: form,
                controller: updation.quantityTextController,
                hintText: TextFieldHint.quantity,
                text: updation.quantity.toString(),
                icon: FontAwesomeIcons.boxOpen,
                color: Palette.primaryColor,
                textColor: Colors.black,
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 25),
              InputField(
                form: form,
                controller: updation.discountTextController,
                hintText: TextFieldHint.discount,
                text: updation.discount.toString(),
                icon: FontAwesomeIcons.percentage,
                color: Palette.primaryColor,
                textColor: Colors.black,
                inputAction: TextInputAction.done,
                inputType: TextInputType.number,
                textLength: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
