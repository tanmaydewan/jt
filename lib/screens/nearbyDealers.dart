import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_in_time/resources/location.dart';
import 'package:just_in_time/screens/checkinoutScreen.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class NearbyDealersScreen extends StatefulWidget {
  @override
  _NearbydealersScreenState createState() => _NearbydealersScreenState();
}

class _NearbydealersScreenState extends State<NearbyDealersScreen> {
  var _isLoading;
  var _dealersLoaded;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _dealersLoaded = false;
    });
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
      child: Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24.0),
              _dealersLoaded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          IconButton(
                              onPressed: () => _backPressed(),
                              icon: Image.asset(
                                "assets/back_icon.png",
                                height: 40,
                                width: 40,
                              )),
                          Text("Nearby Dealers",
                              textAlign: TextAlign.left,
                              textScaleFactor: 2.0,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ])
                  : Column(),
              SizedBox(height: 20.0),
              _dealersLoaded
                  ? _buildDetails()
                  : Text("Please Wait..",
                      textAlign: TextAlign.left,
                      textScaleFactor: 2.0,
                      style: TextStyle(color: Colors.black54)),
              Visibility(
                visible: _isLoading,
                child: CustomProgressIndicatorWidget(),
              )
            ],
          )),
    );
  }

  Widget _buildDetails() {
    return (_dealers != null && _dealers!.length == 0)
        ? Text("No dealers found nearby")
        : Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                _buildDealerMap(),
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _dealers!.length,
                  itemBuilder: (context, index) {
                    final _dealer = _dealers![index];
                    //final userVerified = user.a) ?? false;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CheckinoutScreen(selectedDealer: _dealer)));
                      },
                      child: _buildDealerTile(_dealer),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ))
              ]));
  }

  Widget _buildDealerTile(ParseObject _dealer) {
    // var lat = _dealer.get<ParseGeoPoint>('location')!.latitude;
    // var lon = _dealer.get<ParseGeoPoint>('location')!.longitude;
    var name = _dealer['name'] as String;
    var address = _dealer['address'] as String;
    return SizedBox(
        height: 100, // Some height
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Text(name,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(address,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.0,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.black54))
                ]))));
  }

  Widget _buildDealerMap() {
    return SizedBox(
        height: 220, // Some height
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lon), zoom: 11),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(_getDealerMarkers()),
                ))));
  }

  var lat, lon;
  List<ParseObject>? _dealers;
  ParseObject? _selectedDealer;
  void _getLocation() async {
    List a = await Location().getCurrentLocation();
    if (a.length >= 2) {
      setState(() {
        lat = a[0];
        lon = a[1];
      });
    } else {
      setState(() {
        lat = 31.346822921333068;
        //a[0];
        lon = 75.58387396589404;
        //a[1];
      });
    }
    _getAllNearbyDealers();
  }

  void _backPressed() {
    Navigator.of(context).pop();
  }

  void _getAllNearbyDealers() async {
    // var gp = ParseGeoPoint(latitude: lat, longitude: lon);
    var gp = ParseGeoPoint(
        latitude: 31.346822921333068, longitude: 75.58387396589404);

    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Dealer'));
    parseQuery.whereWithinKilometers('location', gp, 2);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allDealers = apiResponse.results! as List<ParseObject>;
      setState(() {
        _dealers = allDealers;
      });
    }
    setState(() {
      _isLoading = false;
      _dealersLoaded = true;
    });
  }

  Iterable<Marker> _getDealerMarkers() {
    return _dealers != null
        ? Iterable.generate(_dealers!.length, (index) {
            var _dealer = _dealers![index];
            var lat = _dealer.get<ParseGeoPoint>('location')!.latitude;
            var lon = _dealer.get<ParseGeoPoint>('location')!.longitude;
            var name = _dealer['name'] as String;
            var id = _dealer['objectId'] as String;
            return Marker(
                markerId: MarkerId(id),
                position: LatLng(lat, lon),
                infoWindow: InfoWindow(title: name));
          })
        : Iterable.empty();
  }
}
