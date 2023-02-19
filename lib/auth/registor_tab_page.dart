import 'dart:io';
import 'package:amezon_user/auth/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firestorage;
import '../global/global.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  final conpassCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String downloadUrlImg = '';
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  XFile? imgXfile;
  dynamic pickedImageError;

  getImageGallery() async {
    imgXfile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXfile;
    });
  }

  // void _pickImageFromGallery() async {
  //   try {
  //     final pickedImage = await _picker.pickImage(
  //         source: ImageSource.gallery,
  //         maxHeight: 300,
  //         maxWidth: 300,
  //         imageQuality: 95);
  //     setState(() {
  //       imgXfile = pickedImage;
  //     });
  //   } catch (e) {
  //     pickedImageError = e;
  //   }
  // }

  formValidation() async {
    showDialog(
        context: context,
        builder: (c) => const LoadingDialogWidget(
              message: 'Registering your account',
            ));
    if (imgXfile == null) {
      Fluttertoast.showToast(msg: "Please select an image");
      setState(() {
        isLoading = false;
      });
    } else {
      if (passwordCtr.text == conpassCtr.text) {
        if (nameCtr.text.isNotEmpty &&
            emailCtr.text.isNotEmpty &&
            passwordCtr.text.isNotEmpty &&
            conpassCtr.text.isNotEmpty &&
            phoneCtr.text.isNotEmpty) {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          firestorage.Reference ref = firestorage.FirebaseStorage.instance
              .ref()
              .child('usersImg')
              .child(fileName);
          firestorage.UploadTask uploadImgTask =
              ref.putFile(File(imgXfile!.path));
          firestorage.TaskSnapshot taskSnapshot =
              await uploadImgTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((urlImg) {
            downloadUrlImg = urlImg;
          });
          save();
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Password and Confirm Password do not match.');
      }
    }
  }

  @override
  void dispose() {
    nameCtr.dispose();
    emailCtr.dispose();
    phoneCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              getImageGallery();
              // _pickImageFromGallery();
            },
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage:
                  imgXfile == null ? null : FileImage(File(imgXfile!.path)),
              child: imgXfile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      color: Colors.grey,
                      size: MediaQuery.of(context).size.width * 0.2,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
              key: formkey,
              child: Column(
                children: [
                  InputTextField(
                    icon: Icons.person,
                    controller: nameCtr,
                    hintText: 'Name',
                    enabled: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputTextField(
                    icon: Icons.email,
                    controller: emailCtr,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email addres';
                      } else if (value.isValidEmail() == false) {
                        return 'invalid email';
                      } else if (value.isValidEmail() == true) {
                        return null;
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputTextField(
                    icon: Icons.lock,
                    controller: passwordCtr,
                    isObsecre: true,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputTextField(
                    icon: Icons.password_sharp,
                    controller: conpassCtr,
                    isObsecre: true,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (passwordCtr.text != conpassCtr.text) {
                        return 'Password and Confirm Password do not match.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputTextField(
                    icon: Icons.phone,
                    controller: phoneCtr,
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    maxlength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must not be less than eight characters. ';
                      } else {
                        return null;
                      }
                    },
                  ),
                 
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.84,
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.purple,
                  ))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(horizontal: 20)),
                    onPressed: () {
                      formValidation();
                      // signUp();
                    },
                    child: const Text(
                      'Sign Up',
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

  void signUp() async {
    if (imgXfile == null) {
      Fluttertoast.showToast(msg: "Please select an image");
    } else {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          firestorage.Reference ref = firestorage.FirebaseStorage.instance
              .ref()
              .child('usersImg')
              .child(fileName);
          firestorage.UploadTask uploadImgTask =
              ref.putFile(File(imgXfile!.path));
          firestorage.TaskSnapshot taskSnapshot =
              await uploadImgTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((urlImg) {
            downloadUrlImg = urlImg;
          });
          save();

          formkey.currentState!.reset();
          setState(() {
            imgXfile = null;
          });
        } on FirebaseAuthException catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    }
  }

  save() async {
    User? user;
    await auth
        .createUserWithEmailAndPassword(
            email: emailCtr.text..toLowerCase().trim(),
            password: passwordCtr.text.trim())
        .then((auth) {
      user = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Error Qccurred: \n$error');
    });
    if (user != null) {
      setState(() {
        isLoading = false;
      });
      saveInfoFirestore(user);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveInfoFirestore(User? user) async {
    store.collection('users').doc(user!.uid).set({
      'id': user.uid,
      'name': nameCtr.text,
      'email': user.email,
      'phone': phoneCtr.text.trim(),
      'photoUrl': downloadUrlImg,
      'status': 'approved',
      'userCart': ['initialValue'],
    });
    setState(() {
      isLoading = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SplashPage()));
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('id', user.uid);
    await sharedPreferences!.setString('name', nameCtr.text);
    await sharedPreferences!.setString('email', user.email!);
    await sharedPreferences!.setString('phone', phoneCtr.text.trim());
    await sharedPreferences!.setString('photoUrl', downloadUrlImg);
    await sharedPreferences!.setStringList('userCart', ['initialValue']);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z0-9]{2,3})$')
        .hasMatch(this);
  }
}
