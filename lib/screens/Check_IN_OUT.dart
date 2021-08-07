import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_in_time/list.dart';
import 'package:just_in_time/resources/checkInOut.dart';
import 'package:just_in_time/resources/location.dart';
import 'package:just_in_time/resources/server_call.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/screens/timer.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

 
}

class _MyAppState extends State<HomeScreen> {
  final controllerDealerName = TextEditingController()..text= dealerName;

  final controllerDetail = TextEditingController();
  List<ParseObject> results = <ParseObject>[];
  //late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  late Stopwatch stopwatch;
  @override
  void initState() {
    super.initState();
    getLocation();

    start();
    markers = markerSItr;
  }

  var lat, lon;
  void getLocation() async {
    List a = await Location().getCurrentLocation();
    setState(() {
      lat = a[0];
      lon = a[1];
    });
  }

  void start() {
    stopwatch = Stopwatch();

    Timer.periodic(new Duration(milliseconds: 60), (timer) {
      setState(() {
        tm = formatTime(stopwatch.elapsedMilliseconds);
      });
    });
  }

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      start();

      stopwatch.start();
    }
  }

  Future<bool> _onWillPop() async {
    if (stopwatch.isRunning == false) {
      return true;
    } else
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Warning!'),
              content: new Text('Kindly Check Out'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('OK'),
                ),
              ],
            ),
          )) ??
          true;
  }

  void saveDealer() async {
    await dealerStatus(dealerName, controllerDetail.text);

    setState(() {
      controllerDealerName.clear();
      controllerDetail.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Check IN/Check Out')),
          backgroundColor: kColour,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lon), zoom: 11),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(markers),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(dealerName,
                    style: TextStyle(
                        color: kColour,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                    )),
                      ),
                      SizedBox(
                        height:15
                      ),
             RegTextContainer(
                          tController: controllerDetail,
                          tIcon: Icons.description,
                          tLabel: 'Enter Detail'),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.all(20)),
                          Expanded(
                              child: Text(
                            stopwatch.isRunning ? tm : '00:00:00',
                            style: TextStyle(fontSize: 25),
                          )),
                          ElevatedButton(
                            onPressed: () {
                              handleStartStop();
                              setState(() {
                                tm = "00:00:00";
                              });
                              if (stopwatch.isRunning == false) {
                                saveDealer();
                                Navigator.of(context).pop(true);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kColour)),
                            child: Text(
                              stopwatch.isRunning ? 'Check OUT' : 'Check IN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
