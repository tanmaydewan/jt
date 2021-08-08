import 'package:flutter/material.dart';
import 'package:just_in_time/resources/location.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CheckinoutScreen extends StatefulWidget {
  @override
  _CheckinoutScreenState createState() =>
      _CheckinoutScreenState(selectedDealer: this.selectedDealer);

  const CheckinoutScreen({Key? key, required this.selectedDealer})
      : super(key: key);

  // Declare a field that holds the Todo.
  final ParseObject selectedDealer;
}

class _CheckinoutScreenState extends State<CheckinoutScreen> {
  _CheckinoutScreenState({required this.selectedDealer}) : super();

  var _isLoading;
  final ParseObject selectedDealer;
  ParseObject? checkinObject;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
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
    return SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24.0),
                      _buildHeader(),
                      SizedBox(height: 20.0),
                      _buildImageHolder(),
                      _buildCheckinDetails(),
                      _buildCheckoutDetails()
                    ]))));
  }

  Widget _buildHeader() {
    return Row(
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
          Text("Dealer Visit",
              textAlign: TextAlign.left,
              textScaleFactor: 2.0,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        ]);
  }

  Widget _buildImageHolder() {
    const palceholderAsset = 'assets/placeholder.png';
    if (checkinObject != null) {
      var checkinImage = checkinObject!["visitImage"] as String;
      return FadeInImage.assetNetwork(
          placeholder: palceholderAsset, image: checkinImage);
    } else {
      return GestureDetector(
          onTap: () => {_didTapClickPhoto(context)},
          child: (Image.asset(palceholderAsset)));
    }
  }

  Widget _buildCheckinDetails() {
    return Column();
  }

  Widget _buildCheckoutDetails() {
    return Column();
  }

  var lat, lon;
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
    setState(() {
      _isLoading = false;
    });
  }

  void _didTapClickPhoto(BuildContext context) {}

  void _backPressed() {
    Navigator.of(context).pop();
  }
}
