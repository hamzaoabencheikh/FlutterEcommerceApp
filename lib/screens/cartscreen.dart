import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/model/cartmodel.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/cartservices.dart';
import 'package:shoppingapp/widgets/productcartwidget.dart';

class CartScreen extends StatelessWidget {
  var user;
  late CartServices cartprovider;
  CartScreen({super.key});
  int toatl = 0;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      user = context.read<AuthService>().user;
    }
    cartprovider = Provider.of<CartServices>(context, listen: false);
    if (user != null) cartprovider.getCartProduct(user.uid);

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        padding: EdgeInsets.all(7),
        color: Color.fromARGB(255, 139, 139, 139),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CartServices>(
                  builder: (context, cart, child) {
                    return Text(
                      '\$ ${cartprovider.getTotalPrice()}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      body: cartprovider.getCartDataList.isEmpty
          ? Center(
              child: const Text("NO DATA"),
            )
          : Consumer<CartServices>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: cartprovider.getCartDataList.length,
                  itemBuilder: (context, index) {
                    CartModel cartModel = cartprovider.getCartDataList[index];
                    return ProductListWidget(
                      producttitle: cartModel.producttitle,
                      brandname: '',
                      price: cartModel.price,
                      imageurl: cartModel.imageurl,
                      productid: cartModel.cartid, //cart id used here
                      productsize: cartModel.productsize,
                    );
                  },
                );
              },
            ),

      // body: StreamBuilder(
      //     stream: cart.snapshots(),
      //     builder: (context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData) {
      //         return ListView.builder(
      //           itemBuilder: (context, index) {
      //             final DocumentSnapshot cartsnap = snapshot.data.docs[index];

      //             return ProductListWidget(
      //               brandname: '',
      //               imageurl: cartsnap['imageurl'],
      //               price: cartsnap['price'],
      //               productid: cartsnap['productid'],
      //               productsize: cartsnap['productsize'],
      //               producttitle: cartsnap['productname'],
      //             );
      //           },
      //           itemCount: snapshot.data!.docs.length,
      //         );
      //       } else {
      //         return Container();
      //       }
      //     }),
    );
  }
}
