import 'dart:async';

import 'package:flutter/material.dart';

import '../global/global.dart';
import '../pages/home_page.dart';
import 'auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  splashScreen() {
    Timer(const Duration(seconds: 3), () {
      auth.currentUser != null
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()))
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AuthPage()));
    });
  }

  @override
  void initState() {
    splashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade200, Colors.blue.shade100],
            begin: const FractionalOffset(1, 0),
            end: const FractionalOffset(0, 1),
            stops: const [0, 1],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'images/shopping.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'iShop User App',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3),
            )
          ],
        ),
      ),
    );
  }
}
