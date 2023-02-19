import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore store = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
