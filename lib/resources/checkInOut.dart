 import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_in_time/list.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


//display markers
Iterable markers = [];

  Iterable markerSItr = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          lati,
          longe
        ),
        infoWindow: InfoWindow(title: dealerName));
  });

  
  //value for markers
  class AppConstant {
  static List<Map<String, dynamic>> list = [
    {
      "title": "one",
      "id": "1",
      "lat": 31.346822921333068,
      "lon": 75.58387396589404
    },
    {
      "title": "two",
      "id": "2",
      "lat": 31.311807187867863,
      "lon": 75.58225369818153
    },
    {
      "title": "three",
      "id": "3",
      "lat": 31.331167184144086,
      "lon": 75.59086686902205
    },
  ];
}


//Calculate distance
double calculateDistance(lat1, lon1, lat2, lon2){
var p = 0.017453292519943295;
var c = cos;
var a = 0.5 - c((lat2 - lat1) * p)/2 +
c(lat1 * p) * c(lat2 * p) *
(1 - c((lon2 - lon1) * p))/2;
return 12742 * asin(sqrt(a));
}



void getMArk() async {
    var gp = ParseGeoPoint(
        latitude: 31.346822921333068, longitude: 75.58387396589404);

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