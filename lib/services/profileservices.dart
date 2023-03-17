import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/userprovider.dart';

class ProfileServices {
  void getProfileDetails(BuildContext context, String userid) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("userid", isEqualTo: userid)
        .get();

    context.read<UserProvider>().user.username = snapshot.docs[0]['username'];
    context.read<UserProvider>().user.userid = snapshot.docs[0]['userid'];
    context.read<UserProvider>().user.address = snapshot.docs[0]['address'];
    context.read<UserProvider>().user.birthdate = snapshot.docs[0]['birthdate'];
    context.read<UserProvider>().user.city = snapshot.docs[0]['city'];
    context.read<UserProvider>().user.postalcode =
        snapshot.docs[0]['postalcode'];
    context.read<UserProvider>().user.password = snapshot.docs[0]['password'];
  }

  void updateProfile(String password, String dob, String address,
      String postalcode, String city, String userid) async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    currentUser!.updatePassword(password);

    final data = {
      "password": password,
      "birthdate": dob,
      "address": address,
      "postalcode": postalcode,
      "city": city
    };

    user.doc(userid).update(data);
  }
}
