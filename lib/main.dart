import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/provider/userprovider.dart';
import 'package:shoppingapp/screens/loginscreen.dart';
import 'package:shoppingapp/services/authservice.dart';
import 'package:shoppingapp/services/cartservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(FirebaseAuth.instance),
        ),
        Provider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartServices(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
