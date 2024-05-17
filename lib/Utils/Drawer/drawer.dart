// ignore_for_file: unused_import

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:taxiassist/Controller/Google_map/google_map.dart";
import "package:taxiassist/Models/User_Model/usermodel.dart";
import "package:taxiassist/Controller/Themes/Themes.dart";
import "package:taxiassist/Utils/Colors/app_colors.dart";
import "package:taxiassist/Utils/Buttons/drawer_button.dart";
import "package:taxiassist/Utils/Buttons/round_button.dart";
import "package:taxiassist/View/Home_screen/Customer_location_numbers/customer_detailed_location_page.dart";
import "package:taxiassist/View/Home_screen/Customer_location_numbers/customer_location_numbers.dart";
import "package:taxiassist/View/Splash_screen/splash_screen.dart";

class MyDrawer extends StatefulWidget {
  final UserModel userModel;
  final UserModel targetUser;
  
 const MyDrawer({super.key, required this.userModel,  required this.targetUser});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final ThemeController themeController = Get.find<ThemeController>();
  
  get _auth => FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: DrawerHeader(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      widget.userModel.profilePic.toString(),
                    ),
                  ),

            
            SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),

                 Text(
                    widget.userModel.fullname ?? 'User',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

            const SizedBox(height: 30),

            MyDrawerButton(ontap: (){
              Get.to(() => GoogleMaps(
                userModel: widget.userModel,
                targetUser: widget.targetUser,
              ));

            }, text1: "Share information"),

            MyDrawerButton(ontap: (){}, text1: "Train Schedules"),

            MyDrawerButton(ontap: (){

              // Get.to(() => CustomerLocationNumbers(
              //   targetUser: widget.targetUser,
              //   userModel: widget.userModel,
              //   name: widget.userModel.fullname.toString(),
              //   ));
              Get.to(() => CustomerLocationNumbers(
                targetUser: widget.targetUser,
                userModel: widget.userModel,
                

              ));
            }, text1: "Get fare"),

            MyDrawerButton(
                ontap: () {
                  themeController.toggleTheme();
                },
                text1: 'Change Theme'
              ),

            MyDrawerButton(ontap: (){}, text1: "Contact us"),

            MyDrawerButton(ontap: ()async{
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
               _auth.signOut();
               Get.to(() => Splash_Screen(
                userModel: widget.userModel, 
                targetUser: widget.targetUser,
              )
             );
            }, text1: "Log out"),
            
          ],
        ),),
        
      
    );
  }
}