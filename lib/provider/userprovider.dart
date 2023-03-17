import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/model/usermodel.dart';

class UserProvider {
  UserModel _user = UserModel(
      userid: '',
      username: '',
      email: '',
      password: '',
      birthdate: '',
      address: '',
      postalcode: '',
      city: '');

  UserModel get user => _user;
  var testprov = "provider ++++++++++++++++++++++++++";

  void setUserDetails(Map<String, dynamic> data) {
    print(data);
    _user = UserModel.fromJson(data);
    print(user.email);
  }
}
