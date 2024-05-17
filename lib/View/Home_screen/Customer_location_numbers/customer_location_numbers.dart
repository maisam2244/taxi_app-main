import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/Utils/Colors/app_colors.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_detailed_location_page.dart';

class CustomerLocationNumbers extends StatelessWidget {
  final UserModel userModel;
  final UserModel targetUser;
  
  CustomerLocationNumbers({
    Key? key, required this.userModel, required this.targetUser,
  }) : super(key: key);
  final user_appointments =
      FirebaseFirestore.instance.collection("customers_location_name").snapshots();
  // final accepted_appointments =
  //     FirebaseFirestore.instance.collection("Accepted_appoinments");

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.liteblackColor,
      appBar: AppBar(
        title: const Text(
          "Get your fare",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: user_appointments,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text("Loading");
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                       String infoDriverName = snapshot.data!.docs[index]["driver_name"];
                      String infoMapLocationAddress = snapshot.data!.docs[index]["map_location_address"];
                      String numOfPassengers = snapshot.data!.docs[index]["num_of_passengers"];
                      String infoDriverPicUrl = user!.photoURL.toString();
                      String Latitude = snapshot.data!.docs[index]["latitude"];
                      String Longitude = snapshot.data!.docs[index]["longitude"];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => LocationPage(
                            driver_name: infoDriverName.toString(),
                            location_adrress: infoMapLocationAddress, 
                            number_of_passengers: numOfPassengers, 
                            Latitude: Latitude, 
                            Longitude: Longitude,
                            userModel: userModel,
                            targetUser: targetUser

                            ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            height: 120,
                            width: 390,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.blackColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(infoDriverPicUrl),
                                    ),
                                    Text(
                                      infoDriverName,
                                      style: TextStyle(color: AppColors.whiteColor, fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded( // Wrap this Column with Expanded
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center, // Align text to start
                                    children: [
                                     
                                      Text(
                                        infoMapLocationAddress,
                                        style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Passengers: " + numOfPassengers,
                                          style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}