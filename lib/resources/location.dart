import 'package:geolocator/geolocator.dart';

class Location {
  late double longitude  ;
  late double latitude ;
  List a =[] ;


  Future<List> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude = position.longitude;
      latitude = position.latitude;
             a.add(latitude);
      a.add(longitude);
      
    } catch (e) {
      print(e);
    }
    
    return a;
  }
}
