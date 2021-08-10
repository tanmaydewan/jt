import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_in_time/list.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

//display markers
Iterable markers = [];

Iterable markerSItr = Iterable.generate(AppConstant.list.length, (index) {
  return Marker(
      markerId: MarkerId("1"),
      position: LatLng(lati, longe),
      infoWindow: InfoWindow(title: dealerName));
});

//value for markers
class AppConstant {
  static List<Map<String, dynamic>> list = [];
  static List<Map<String, dynamic>> listEmp = [
    {
      "username": "Karan",
      "email":"Karan@kubtechsolution.com"
    },
    {
      "username": "Dwight Schrute",
      "email":"dschrute@company.com"
    },
    {
      "username": "Michael Scott",
      "email":"mscott@company.com"
    },
    { 
      "username": "Abhishek Attri",
      "email":"abhishekattri@gmail.com"
    },
    { 
      "username": "Utkarsh Dhiman",
      "email":"utkarsh@email.com"
    },
    { 
      "username": "Tanmay",
      "email":"tanmay@gmail.com"
    },
   { 
      "username": "Pranshu",
      "email":"pranshu@gmail.com"
    },
    { 
      "username": "Chetan",
      "email":"chetan@mail.com"
    },

  ];
}

//Calculate distance
double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

void getMArk() async {
  var gp =
      ParseGeoPoint(latitude: 31.346822921333068, longitude: 75.58387396589404);

  final QueryBuilder<ParseObject> parseQuery =
      QueryBuilder<ParseObject>(ParseObject('Dealer'));
  parseQuery.whereWithinKilometers('location', gp, 4);

  final ParseResponse apiResponse = await parseQuery.query();

  if (apiResponse.success && apiResponse.results != null) {
    for (var o in apiResponse.results! as List<ParseObject>) {
      var lat = o.get<ParseGeoPoint>('location')!.latitude;
      var lon = o.get<ParseGeoPoint>('location')!.longitude;
      print(lon);
      var ab = {
        'title': o['name'],
        "id": "4",
        'lat': lat,
        'lon': lon,
      };

      AppConstant.list.add(ab);
      print(
          'City: ${o.get<String>('name')} - Location: ${o.get<ParseGeoPoint>('location')!.latitude}, ${o.get<ParseGeoPoint>('location')!.longitude}');
      print(AppConstant.list);
    }
  }
  ;
}

void getEmp() async {
  var gp =
      ParseGeoPoint(latitude: 31.346822921333068, longitude: 75.58387396589404);

  final QueryBuilder<ParseObject> queryUsers =
      QueryBuilder<ParseObject>(ParseObject("User"));

  final ParseResponse apiResponse = await queryUsers.query();

  if (apiResponse.success && apiResponse.results != null) {
    for (var o in apiResponse.results! as List<ParseObject>) {
      var lat = o.get<ParseGeoPoint>('location')!.latitude;
      var lon = o.get<ParseGeoPoint>('location')!.longitude;
      print(lon);
      var ab = {
        'NameEmp': o['Username'],
        "id": "4",
        'EmailEmp': o['email'],
        
      };

      AppConstant.list.add(ab);
      print(
          'City: ${o.get<String>('name')} - Location: ${o.get<ParseGeoPoint>('location')!.latitude}, ${o.get<ParseGeoPoint>('location')!.longitude}');
      print(AppConstant.list);
    }
  }
  ;
}
