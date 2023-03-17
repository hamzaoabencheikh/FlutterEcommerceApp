import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/constants/utils.dart';
import 'package:shoppingapp/model/usermodel.dart';
import 'package:shoppingapp/provider/userprovider.dart';
import 'package:shoppingapp/screens/profilescreen.dart';
import 'package:shoppingapp/services/profileservices.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);
  User get user => _auth.currentUser!;

  Future<bool> loginWithUsername(
      BuildContext context, String username, String password) async {
    bool isVerified = false;
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where("username", isEqualTo: username)
        .get();

    if (snap.size == 0) {
      showSnackBar(context, 'user not exist');
      print('user not exist');
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: snap.docs[0]['email'], password: password);
        isVerified = true;
      } catch (e) {
        print('check password');
        print(e);
      }
    }
    return isVerified;
  }

  userSignOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
