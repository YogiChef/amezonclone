import 'package:amezon_user/auth/registor_tab_page.dart';
import 'package:flutter/material.dart';

import 'login_tab_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.pink],
                  begin: const FractionalOffset(0, 0),
                  end: const FractionalOffset(1, 0),
                  stops: const [0, 1]),
            ),
          ),
          bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  text: 'Login',
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  text: 'Registor',
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
              ]),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.deepOrange.shade200],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 0),
                stops: const [0, 1]),
          ),
          child: const TabBarView(children: [
            LoginTabPage(),
            RegisterPage(),
          ]),
        ),
      ),
    );
  }
}
