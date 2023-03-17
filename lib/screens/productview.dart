import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/constants/custometextstyle.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/cartservices.dart';

class ProductView extends StatefulWidget {
  final String producttitle;
  final String brandname;
  final String price;
  final String productid;
  final String productsize;
  final String imageurl;
  final String productdescription;
  const ProductView(
      {super.key,
      required this.producttitle,
      required this.brandname,
      required this.price,
      required this.imageurl,
      required this.productid,
      required this.productsize,
      required this.productdescription});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late CartServices cartProvider;
  CustomeTextStyle customeTextStyle = CustomeTextStyle();
  late ScrollController _scrollController;
  bool _isScrolled = false;
  bool _showAppbar = false;

  _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrolled) {
        _isScrolled = true;
        _showAppbar = true;
        setState(() {});
      }
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrolled) {
        _isScrolled = false;
        _showAppbar = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartServices>(context, listen: false);
    var user = context.read<AuthService>().user;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: _showAppbar
          ? null
          : IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: Icon(Icons.arrow_back)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
            onPressed: () {
              cartProvider.addToCart(
                  user.uid,
                  widget.productid,
                  widget.producttitle,
                  widget.price,
                  widget.imageurl,
                  widget.productsize);
              cartProvider
                  .getCartProduct(FirebaseAuth.instance.currentUser!.uid);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.shopping_cart), Text('Add To cart')],
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppbar ? 70.0 : 0.0,
              duration: const Duration(
                milliseconds: 100,
              ),
              child: AppBar(
                backgroundColor: Colors.red,
                title: Text('appname'),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      height: 300,
                      child: Image.network(
                        widget.imageurl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.brandname,
                            style: TextStyle(
                                color: Colors.lightBlue[300],
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.producttitle,
                            style: customeTextStyle.productTitle,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Color : Black'),
                          Text('Size  : ${widget.productsize}')
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$ ${widget.price}'),
                          
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.circular(1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Description'),
                          Text(
                            widget.productdescription,
                            style: customeTextStyle.productDescription,
                          )
                        ],
                      ),
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
