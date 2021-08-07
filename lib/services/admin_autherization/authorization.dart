import 'package:door_shop_admin/services/admin_autherization/admin_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationService{
  final FirebaseAuth _authorization = FirebaseAuth.instance;

  AdminID _adminFromFirebase(User admin){
    return admin != null ? AdminID(uid: admin.uid) : null;
  }

  Stream<AdminID> get admin {
    return _authorization.authStateChanges().map((_adminFromFirebase));
  }

  // Login
  Future adminLogin({@required String email, @required String password}) async {
    try{
      UserCredential result = await _authorization.signInWithEmailAndPassword(email: email, password: password);
      User admin = result.user;
      return _adminFromFirebase(admin);

    } catch (e) {
      print(e.toString());
      return e.hashCode;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _authorization.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}