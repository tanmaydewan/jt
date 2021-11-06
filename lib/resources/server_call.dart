import 'package:just_in_time/resources/location.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future<void> saveReg(String dealerName, String address, String pincode,
    String taxNumber, String phoneNumber, String imagePath) async {
  await Future.delayed(Duration(seconds: 1), () {});
  Location lt = Location();

  await lt.getCurrentLocation();

  final location =
      ParseGeoPoint(latitude: lt.latitude, longitude: lt.longitude);

  final regObj = ParseObject('Dealer')
    ..set('name', dealerName)
    ..set('address', address)
    ..set('location', location)
    ..set('pincode', pincode)
    ..set('TaxNumber', taxNumber)
    ..set('phoneNumber', phoneNumber)
    ..set("dealerImage", imagePath);
  await regObj.save();

  // final ParseResponse parseResponse = await regObj.save();
  // if (parseResponse.success) {
  //   print("Dealer saved");
  //   // _navigateToNextScreen(context);
  // } else {
  //   print("Dealer not save due to error");
  // }
}

Future<void> dealerStatus(String dealerName, String discription) async {
  await Future.delayed(Duration(seconds: 1), () {});
  Location lt = Location();

  await lt.getCurrentLocation();

  final location =
      ParseGeoPoint(latitude: lt.latitude, longitude: lt.longitude);

  final regObj = ParseObject('DealerVisits')
    ..set('name', dealerName)
    ..set('location', location);
  await regObj.save();
}


// void _backPressed() {
//   Navigator.of(context);
// }
