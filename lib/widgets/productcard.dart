import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppingapp/constants/custometextstyle.dart';
import 'package:shoppingapp/screens/productview.dart';

class ProductCard extends StatelessWidget {
  String producttitle;
  String brandname;
  String price;
  String productid;
  String productsize;
  String imageurl;
  String productdescription;
  ProductCard(
      {super.key,
      required this.producttitle,
      required this.brandname,
      required this.price,
      required this.imageurl,
      required this.productid,
      required this.productsize,
      required this.productdescription});
  final CustomeTextStyle _textStyle = CustomeTextStyle();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductView(
            brandname: brandname,
            imageurl: imageurl,
            price: price,
            productdescription: productdescription,
            producttitle: producttitle,
            productid: productid,
            productsize: productsize,
          ),
        ));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(imageurl, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producttitle,
                      style: _textStyle.productTitle,
                    ),
                    Text(
                      productsize,
                      style: _textStyle.productSize,
                    ),
                    Text(
                      price,
                      style: _textStyle.productPrice,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
