import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/userprovider.dart';
import 'package:shoppingapp/screens/loginscreen.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/profileservices.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  ProfileServices _profileServices = ProfileServices();
  TextEditingController _usernameeditingController = TextEditingController();
  TextEditingController _passwordeditingController = TextEditingController();
  TextEditingController _birthdateeditingController = TextEditingController();
  TextEditingController _addresseditingController = TextEditingController();
  TextEditingController _postalcodeeditingController = TextEditingController();
  TextEditingController _cityeditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void setText(BuildContext context) {
    _usernameeditingController.text =
        context.read<UserProvider>().user.username;
    _passwordeditingController.text =
        context.read<UserProvider>().user.password;
    _birthdateeditingController.text =
        context.read<UserProvider>().user.birthdate;
    _addresseditingController.text = context.read<UserProvider>().user.address;
    _postalcodeeditingController.text =
        context.read<UserProvider>().user.postalcode;
    _cityeditingController.text = context.read<UserProvider>().user.city;
  }

  void updateProfile(String userid) {
    _profileServices.updateProfile(
        _passwordeditingController.text,
        _birthdateeditingController.text,
        _addresseditingController.text,
        _postalcodeeditingController.text,
        _cityeditingController.text,
        userid);
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      user = context.read<AuthService>().user;
      _profileServices.getProfileDetails(context, user.uid);
      setText(context);
    }
  
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    controller: _usernameeditingController,
                    decoration: const InputDecoration(label: Text('username')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordeditingController,
                    obscureText: true,
                    decoration: const InputDecoration(label: Text('password')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _birthdateeditingController,
                    keyboardType: TextInputType.datetime,
                    decoration:
                        const InputDecoration(label: Text('Date of Birth')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _addresseditingController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(label: Text('Address')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _postalcodeeditingController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(label: Text('Postal code')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _cityeditingController,
                    decoration: const InputDecoration(label: Text('City')),
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<AuthService>().userSignOut(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text('Logout')),
                  ElevatedButton(
                      onPressed: () {
                        updateProfile(user.uid);
                      },
                      child: const Text('Save')),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
