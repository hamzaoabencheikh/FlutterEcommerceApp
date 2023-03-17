import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/screens/addproductscreen.dart';
import 'package:shoppingapp/screens/cartscreen.dart';
import 'package:shoppingapp/screens/productlist.dart';
import 'package:shoppingapp/screens/profilescreen.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/profileservices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileServices _profileServices = ProfileServices();
  int _selectedIndex = 0;
  List<Widget> homescreenitems = [
    ProductList(),
    const AddProductScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onNavigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        children: homescreenitems,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          onTap: onNavigationTapped,
          elevation: 16.0,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
              label: 'Buy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.create,
              ),
              label: 'Add Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
              ),
              label: 'cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              label: 'Profile',
            ),
          ]),
    );
  }
}
