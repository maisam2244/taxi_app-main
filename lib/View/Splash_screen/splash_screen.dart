// ignore_for_file: unused_import

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxiassist/Controller/Splash_Screen/splash_screen_controller.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/View/Home_screen/Login/login.dart';

class Splash_Screen extends StatelessWidget {
  final UserModel userModel;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final UserModel targetUser;
  Splash_Screen({super.key, required this.userModel, required this.targetUser});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Center(
        child:  Text("Paris Taxi App", style: TextStyle(fontSize: 30),), 
         ), 
      nextScreen: Login_Page(
        userModel: userModel ,
        targetUser: targetUser
      )
    );
  }
}

// class Splash_Screen extends StatefulWidget {
//   final UserModel userModel;
//   final User firebaseUser;
  
//    Splash_Screen({super.key, required this.userModel, required this.firebaseUser});

//   @override
//   State<Splash_Screen> createState() => _Splash_ScreenState();
// }

// class _Splash_ScreenState extends State<Splash_Screen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final splashScreen = SplashScreenController(
//       firebaseUser : widget.firebaseUser,
//     );
//     splashScreen.splashTimer();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body:  Center(
//         child:  Text("Paris Taxi App", style: TextStyle(fontSize: 30),),
        
//       )
//     );
//   }
// }