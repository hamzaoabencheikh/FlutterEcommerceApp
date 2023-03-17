import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/constants/utils.dart';
import 'package:shoppingapp/screens/homescreen.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/profileservices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ProfileServices _profileservice = ProfileServices();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIAGED'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _usernameEditingController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: Text('username'),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3, color: Colors.black)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _passwordEditingController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            label: Text('password'),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3, color: Colors.black)))),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (_usernameEditingController.text.isEmpty &&
                    _passwordEditingController.text.isEmpty) {
                  showSnackBar(context, 'enter username & password');
                } else {
                  bool verifid = await context
                      .read<AuthService>()
                      .loginWithUsername(
                          context,
                          _usernameEditingController.text,
                          _passwordEditingController.text);
                  if (verifid) {
                       Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                    showSnackBar(context, 'Success fully loges in ');
                  }

                }
              },
              child: const Text('Login'))
        ],
      ),
    );
  }
}
