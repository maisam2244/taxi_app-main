// ignore_for_file: unused_import, unused_field, file_names, unnecessary_import, camel_case_types, prefer_const_constructors, unused_label, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Controller/Google_map/google_map.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/Utils/Drawer/drawer.dart';
import 'package:taxiassist/Utils/Colors/app_colors.dart';
import 'package:taxiassist/Utils/Buttons/drawer_button.dart';
import 'package:taxiassist/View/Splash_screen/splash_screen.dart';

class Home_Page extends StatefulWidget {
  final UserModel userModel;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final UserModel targetUser;

  Home_Page({Key? key, required this.userModel, required this.targetUser}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
            "Events",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35
            ),
          ),
      ),
      drawer: MyDrawer(
        userModel: widget.userModel,
        targetUser: widget.targetUser,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('admin_panel_events').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                  var event = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.event_available_outlined,
                            color: AppColors.whiteColor,
                            size: 25,
                          ),
                          SizedBox(width: 10), 
                          Text(
                            "Event: ${event['event_name']}",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              
                      subtitle: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                             
                              Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
              
                              SizedBox(width: 5), 
              
                              Text(
                                "Date: ${event['date']}",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
              
                                ),
                              ),
                            ],
                          ),
              
                          SizedBox(
                            height: 10,
                          ),
              
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
              
                              SizedBox(width: 5), 
              
                              Text(
                                "Time: ${event['time']}",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
              
                                ),
                              ),
                            ],
                          ),
              
                          SizedBox(
                            height: 10,
                          ),
              
                          Row(
                            children: [
                             
                              Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
              
                              SizedBox(width: 5), 
              
                              Text(
                                "Expected Passengers: ${event['expected_passengers']}", 
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
              
                                ),
                              ),
                            ],
                          ),
              
                          SizedBox(
                            height: 10,
                          ),
              
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.whiteColor,
                                size: 18,
                              ),
              
                              SizedBox(width: 5), 
              
                              Expanded(
                                child: Text(
                                  "Location: ${event['location']}",
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 15,
                                
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
