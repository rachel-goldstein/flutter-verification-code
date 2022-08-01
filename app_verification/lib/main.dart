import './screen/send_verification_screen.dart';
import './screen/after_verification_screen.dart';
import './screen/verification_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Verification Code',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: const SendVerificationScreen(),
        routes: {
          AfterVerificationScreen.routeName: (context) =>
              AfterVerificationScreen(),
          VerificationScreen.routeName: (context) => VerificationScreen(),
        });
  }
}
