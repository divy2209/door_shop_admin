import 'package:flutter/material.dart';

class Validation{

  String emailValidation({@required value}) {
    String pattern = r'(^[a-z0-9]+([-+._][a-z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2}$)';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  String passwordValidation({@required value}) {
    String pattern = r'(^\S{8,}$)';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(value)){
      return 'Please enter a valid password';
    } else {
      return null;
    }
  }

}

class CredentialValidation {

  String loginValidation ({@required email, @required password}) {
    String emailError = Validation().emailValidation(value: email ?? '');
    String passwordError = Validation().passwordValidation(value: password ?? '');

    if(emailError == null && passwordError == null) {
      return null;
    } else if(emailError != null) {
      return emailError;
    } else {
      return passwordError;
    }
  }

}