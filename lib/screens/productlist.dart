import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppingapp/widgets/productcard.dart';
import 'package:shoppingapp/widgets/productcartwidget.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder(
              stream: products.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 3
                            : 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: (1 / 1),
                        mainAxisExtent: 250),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot productSnap =
                          snapshot.data.docs[index];

                      return ProductCard(
                        producttitle: productSnap['product_name'],
                        brandname: productSnap['product_brandname'],
                        price: productSnap['product_price'].toString(),
                        imageurl: productSnap['product_imageurl'],
                        productid: productSnap.id,
                        productsize: productSnap['product_size'],
                        productdescription: '',
                      );
                    },
                  );
                } else {
                  return Container();
                }
              })),
    );
  }
}
