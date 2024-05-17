

// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:taxiassist/Model/User_Model/usermodel.dart';
// import 'package:taxiassist/View/Home_screen/Home_page.dart';
// import 'package:taxiassist/View/Home_screen/Login/login.dart';

// class SplashScreenController  {
// User? _user;

// final UserModel userModel;
// final UserModel targetUser;
// final User firebaseUser;

//   SplashScreenController(this.targetUser, this.userModel, this.firebaseUser, {required User firebaseUser},);

//   void splashTimer() {
//     if(_user != null){
//       Timer(const Duration(seconds: 3), () { 
//               Get.to(() => Home_Page(
//                 userModel: userModel,
//                 firebaseUser: firebaseUser,
//                 targetUser: targetUser
//               ));

//       });
//     }
//     else {
//       Timer(const Duration(seconds: 3), () { 
//               Get.to(() => const Login_Page());

//       });
//     }
//   }
  
// }