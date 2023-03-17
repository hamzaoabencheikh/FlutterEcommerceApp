import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/screens/productview.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/cartservices.dart';

class ProductListWidget extends StatelessWidget {
  String producttitle;
  String brandname;
  String price;
  String productid;
  String productsize;
  String imageurl;

  ProductListWidget({
    super.key,
    required this.producttitle,
    required this.brandname,
    required this.price,
    required this.imageurl,
    required this.productid,
    required this.productsize,
  });
  late CartServices cartprovider;
  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthService>().user;
    cartprovider = Provider.of<CartServices>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(0, 0))
                ]),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 100,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      imageurl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producttitle,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Row(
                          children: [
                            const Text(
                              'Size ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                            Text(productsize)
                          ],
                        ),
                      ),
                      Text(
                        "\$ $price",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      cartprovider.cartDataDelete(productid, user.uid);
                      cartprovider.getCartProduct(user.uid);
                      cartprovider.getTotalPrice();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
