import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:just_in_time/resources/location.dart';
import 'package:just_in_time/screens/registration_Screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future<void> saveReg(String dealerName, String address, String pincode, String taxNumber, dynamic imagePath) async {
    await Future.delayed(Duration(seconds: 1), () {});
    Location lt = Location();
    
     
    await lt.getCurrentLocation();
    
    final location = ParseGeoPoint(latitude: lt.latitude , longitude: lt.longitude); 
    final imagep =(Uri.file(imagePath));
    
    final regObj = ParseObject('Dealer')..set('name', dealerName)..set('address', address)..set('location',location)..set('pincode', pincode)..set('TaxNumber', taxNumber)..set("image",imagep );
    await regObj.save();
  }