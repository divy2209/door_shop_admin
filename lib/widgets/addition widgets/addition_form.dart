import 'package:door_shop_admin/services/addition_data.dart';
import 'package:door_shop_admin/services/config.dart';
import 'package:door_shop_admin/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../addition_radio_field.dart';
import '../text_field.dart';

class AdditionForm extends StatelessWidget {
  final String form = FormIdentifier.addition;

  @override
  Widget build(BuildContext context) {
    final addition = Provider.of<AdditionData>(context, listen: false);
    return Form(
      child: Column(
        children: [
          InputField(
            form: form,
            controller: addition.identifierTextController,
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
            controller: addition.nameTextController,
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
            controller: addition.priceTextController,
            hintText: TextFieldHint.price,
            icon: FontAwesomeIcons.rupeeSign,
            color: Palette.primaryColor,
            textColor: Colors.black,
            inputType: TextInputType.number,
            inputAction: TextInputAction.done,
            textLength: 3,
          ),
          AdditionRadioField(
            form: form,
          ),
          InputField(
            form: form,
            controller: addition.quantityTextController,
            hintText: TextFieldHint.quantity,
            icon: FontAwesomeIcons.boxOpen,
            color: Palette.primaryColor,
            textColor: Colors.black,
            inputType: TextInputType.number,
            inputAction: TextInputAction.next,
          ),
          SizedBox(height: 25),
          InputField(
            form: form,
            controller: addition.discountTextController,
            hintText: TextFieldHint.discount,
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
  }
}
