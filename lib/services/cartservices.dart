import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/model/cartmodel.dart';

class CartServices extends ChangeNotifier {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('users');
  Stream<QuerySnapshot<Map<String, dynamic>>> getCartList(String userid) {
    return cart.doc(userid).collection('usercart').snapshots();
  }

  addToCart(String userid, String productid, String productname, String price,
      String imgurl, String size) async {
    Map<String, dynamic> adddata = {
      "productid": productid,
      "productname": productname,
      "price": price,
      "productsize": size,
      "imageurl": imgurl
    };
    await cart.doc(userid).collection("usercart").add(adddata);
  }

  List<CartModel> cartList = [];
  getCartProduct(String userid) async {
    List<CartModel> newList = [];
    QuerySnapshot cartValue = await FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .collection("usercart")
        .get();

    cartValue.docs.forEach((element) {
      CartModel cartModel = CartModel(
          producttitle: element.get('productname'),
          brandname: '',
          price: element.get('price'),
          imageurl: element.get('imageurl'),
          productid: element.get('productid'),
          productsize: element.get('productsize'),
          cartid: element.id);
      newList.add(cartModel);
    });
    cartList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartDataList {
    return cartList;
  }

  getTotalPrice() {
    double total = 0.0;
    cartList.forEach((element) {
      total += double.parse(element.price);
    });
    return total;
  }

  cartDataDelete(cartId, userid) {
    print(cartId);
    print(userid);
    FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .collection("usercart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}
