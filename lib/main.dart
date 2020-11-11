import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/Login.dart';
import 'UI/Home.dart';
import 'UI/Registration.dart';
import 'UI/Chat.dart';
import 'UI/my_image.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => MyHome(),
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "chat": (context) => MyChat(),
        "myimage": (context) => MyImage(),
        
      },
    ),
  );
}



