// ignore_for_file: unused_import, prefer_const_constructors_in_immutables


import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Controller/Google_map/google_map.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/Controller/Themes/Themes.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_location_numbers.dart';
import 'package:taxiassist/View/Home_screen/Home_page.dart';
import 'package:taxiassist/View/Home_screen/Login/login.dart';
import 'package:taxiassist/View/Home_screen/OTP/otp.dart';
import 'package:taxiassist/View/Home_screen/OTP/phone.dart';
import 'package:taxiassist/View/Home_screen/Register/register.dart';
import 'package:taxiassist/View/Splash_screen/splash_screen.dart';
import 'package:taxiassist/firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  final UserModel? userModel;
  final User? firebaseUser;
  final UserModel? targetUser;

  MyApp({Key? key, this.userModel,  this.targetUser, this.firebaseUser}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    final lightTheme = ThemeData(
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      // home: GoogleMaps(userModel: widget.userModel ?? UserModel(), targetUser: null,),
      home: Splash_Screen(
        userModel: widget.userModel ?? UserModel(), 
        targetUser: widget.targetUser ?? UserModel(),
      ),
    );
  }
}


