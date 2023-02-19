// ignore_for_file: use_build_context_synchronously

import 'package:amezon_user/auth/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/textfield.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({super.key});

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  login() {
    if (emailCtr.text.isNotEmpty && passwordCtr.text.isNotEmpty) {
      loginnow();
    } else {
      Fluttertoast.showToast(msg: 'Please provide email and password.');
    }
  }

  loginnow() async {
    showDialog(
        context: context,
        builder: (c) => const LoadingDialogWidget(
              message: 'Checking credentials',
            ));
    User? user;
    await auth
        .signInWithEmailAndPassword(
            email: emailCtr.text..toLowerCase().trim(),
            password: passwordCtr.text.trim())
        .then((auth) {
      user = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Error Qccurred: \n$error');
    });
    if (user != null) {
      checkIfUserRecordExists(user!);
    }
  }

  checkIfUserRecordExists(User user) async {
    await store.collection('users').doc(user.uid).get().then((record) async {
      if (record.exists) {
        if (record.data()!['status'] == 'approved') {
          await sharedPreferences!.setString('id', record.data()!['id']);
          await sharedPreferences!.setString('name', record.data()!['name']);
          await sharedPreferences!.setString('email', record.data()!['email']);
          await sharedPreferences!
              .setString('photoUrl', record.data()!['photoUrl']);

          List<String> userCartList = record.data()!['userCart'].cast<String>();
          await sharedPreferences!.setStringList('userCart', userCartList);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SplashPage()));
        } else {
          auth.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: 'you have BLOCKED by admin.\ncontact Admin: admim');
        }
      } else {
        auth.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'This record do not exists.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputTextField(
                    icon: Icons.email,
                    controller: emailCtr,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  InputTextField(
                    icon: Icons.lock,
                    controller: passwordCtr,
                    isObsecre: true,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.84,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 20)),
                onPressed: () {
                  login();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
