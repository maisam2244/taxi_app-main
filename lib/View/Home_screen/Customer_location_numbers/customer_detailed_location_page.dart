import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiassist/Models/User_Model/usermodel.dart';
import 'package:taxiassist/Utils/Buttons/map_button.dart';
import 'package:taxiassist/Utils/Colors/app_colors.dart';
import 'package:taxiassist/Utils/Drawer/drawer.dart';
import 'package:taxiassist/Utils/textfield/text_fields.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_location_numbers.dart';

class LocationPage extends StatefulWidget {
  final UserModel userModel;
  final UserModel targetUser;
  final String driver_name;
  final String location_adrress;
  final String number_of_passengers;
  final String Latitude;
  final String Longitude;

  const LocationPage({
    Key? key,
    required this.driver_name,
    required this.location_adrress,
    required this.number_of_passengers,
    required this.Latitude,
    required this.Longitude,
    required this.userModel,
    required this.targetUser,
  }) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.8846, 67.1754),
    zoom: 16,
  );
  final List<Marker> _marker = [];

  final List<Marker> _list = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(24.8846, 70.1754),
      infoWindow: InfoWindow(title: "Current Location"),
    )
  ];
  String stAddress = '';

  TextEditingController num_of_passengers = TextEditingController();
  TextEditingController location_name = TextEditingController();
  var dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    // Convert latitude and longitude strings to double
    double latitude = double.parse(widget.Latitude);
    double longitude = double.parse(widget.Longitude);
    // Define the new camera position
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 16,
    );
    // Animate the camera to the new position
    _animateCameraToPosition(initialCameraPosition);
  }

  Future<void> _animateCameraToPosition(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Location"),
      ),
      drawer: MyDrawer(
        userModel: widget.userModel,
        targetUser: widget.targetUser,
      ),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: kGooglePlex,
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: MapButton(
          text: "Driver Details",
          ontap: () async {
            getUserCurrentLocation().then((value) async {
              print("My Location");
              print(dateTime);
              print("${value.latitude} ${value.longitude}");
              _marker.add(Marker(
                markerId: const MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: "My Location"),
              ));

              List<Placemark> placemarks = await placemarkFromCoordinates(
                  value.latitude, value.longitude);
              stAddress =
                  "${placemarks.reversed.last.country} ${placemarks.reversed.last.locality} ${placemarks.reversed.last.street}";
              CameraPosition cameraPosition = CameraPosition(
                zoom: 16,
                target: LatLng(
                  value.latitude,
                  value.longitude,
                ),
              );
              final GoogleMapController controller =
                  await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            });
            Get.bottomSheet(
              Container(
                height: 800,
                width: double.infinity,
                color: Get.isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Driver's Details",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        widget.driver_name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.location_adrress,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.number_of_passengers,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }
}
