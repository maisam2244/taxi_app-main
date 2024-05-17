// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/Utils/Colors/app_colors.dart';
import 'package:taxiassist/Utils/Buttons/round_button.dart';
import 'package:taxiassist/Controller/Authentication/GoogleAuth/auth_service.dart';
import 'package:taxiassist/View/Home_screen/Login/login.dart';

class  Register_Page extends StatelessWidget {
  final UserModel userModel;
  final  firebaseUser = FirebaseAuth.instance.currentUser; 
  final UserModel targetUser;
  Register_Page({super.key, required this.userModel, required this.targetUser});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
          child: Center(
            child: Column(
              children: [

                Image.asset("assets/images/Overlay.png"),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Infos ",
                      style: TextStyle(
                        color: AppColors.purpleColor,
                        fontSize: 40, 
                        fontWeight: FontWeight.w900
                      )
                    ),

                    const Text("Driver",
                      style: TextStyle(
                        fontSize: 40, 
                        fontWeight: FontWeight.w900
                      )
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                const Text("drive with us.",
                    style: TextStyle(
                    fontSize: 35, 
                    fontWeight: FontWeight.w800
                  )
                ),

                const Text("earn extra money",
                    style: TextStyle(
                    fontSize: 35, 
                    fontWeight: FontWeight.w400
                  )
                ),

                const SizedBox(
                  height: 70,
                ),

                  MyButton(
                    ontap: () {
                      return AuthServiceUserRegister(
                        targetUser,
                        userModel: userModel,
                      ).signInWithGoogle();
                    },

                    text: "Sign up with Google"
                  ),

                SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                GestureDetector(
                  onTap: () {
                    Get.to(() => Login_Page(
                      targetUser: UserModel(), 
                      userModel:  UserModel(), 
                      
                    ));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),

                        Text("Login Now",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),),
                  
                    ]
                  )
                ),

                
                  ],
                )
              )
            )
          );                    
  }
}