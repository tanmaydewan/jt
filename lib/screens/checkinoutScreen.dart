import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as HTTP;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_in_time/resources/location.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:just_in_time/widgets/rounded_button_widget.dart';
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

  TextEditingController _noteEditorController = TextEditingController();

  var _isLoading;
  final ParseObject selectedDealer;
  ParseObject? checkinObject;
  File? _selectedImage;

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
                      _buildHeader(),
                      SizedBox(height: 20.0),
                      _buildImageHolder(),
                      _buildCheckinDetails(),
                      Visibility(
                        visible: _isLoading,
                        child: CustomProgressIndicatorWidget(),
                      )
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
    if (_isCheckedIn()) {
      var checkinImage = checkinObject!["visitImage"] as String;
      return FadeInImage.assetNetwork(
          placeholder: palceholderAsset, image: checkinImage);
    } else if (_selectedImage != null) {
      return GestureDetector(
          onTap: () => {_didTapClickPhoto(context)},
          child: (Image.file(_selectedImage!)));
    } else {
      return GestureDetector(
          onTap: () => {_didTapClickPhoto(context)},
          child: (Image.asset(palceholderAsset)));
    }
  }

  Widget _buildCheckinDetails() {
    var name = selectedDealer['name'] as String;
    var address = selectedDealer['address'] as String;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Text("Dealer",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black87, fontSize: 12.0)),
        Text(name,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
        Text(address,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 14.0)),
        SizedBox(height: 12.0),
        !_isCheckedIn()
            ? Text("Location Logged!!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0))
            : Column(),
        SizedBox(height: 24.0),
        _buildCheckinButton(),
        _buildNotesField(),
        _buildCheckoutButton()
      ],
    );
  }

  Widget _buildCheckinButton() {
    return _isCheckedIn()
        ? Column()
        : RoundedButtonWidget(
            buttonText: 'Check in',
            buttonColor: Colors.orange.shade700,
            textColor: Colors.white,
            onPressed: () => _didPressCheckin(context),
          );
  }

  Widget _buildNotesField() {
    return _isCheckedIn()
        ? TextField(
            controller: _noteEditorController,
            maxLines: 5,
            decoration:
                InputDecoration.collapsed(hintText: "Enter your notes here"),
          )
        : Column();
  }

  Widget _buildCheckoutButton() {
    return _isCheckedIn()
        ? RoundedButtonWidget(
            buttonText: 'Check out',
            buttonColor: Colors.teal.shade800,
            textColor: Colors.white,
            onPressed: () => _didPressCheckout(context),
          )
        : Column();
  }

  bool _isCheckedIn() {
    return checkinObject != null;
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

  void _didTapClickPhoto(BuildContext context) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 30);
    setState(() {
      _selectedImage = File(image!.path);
    });
  }

  void _didPressCheckin(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_selectedImage == null) {
      _showErrorMessage("Please take a live photo to checkin", context);
      setState(() {
        _isLoading = false;
      });
      return;
    }
    var imageUrl = await uploadImage(_selectedImage!.path);
    if (imageUrl.length == 0) {
      _showErrorMessage("Unable to upload photo, Please try again", context);
      setState(() {
        _isLoading = false;
      });
      return;
    }
    var checkinObjectResp = await logDealerVisit(imageUrl);
    setState(() {
      _isLoading = false;
    });
    print("Done done done");
    if (checkinObjectResp != null) {
      print(checkinObjectResp["objectId"]);
      setState(() {
        checkinObject = checkinObjectResp;
      });
    }
  }

  void _didPressCheckout(BuildContext context) async {
    if (checkinObject == null) {
      _showErrorMessage("Checkin object not found", context);
      return;
    }
    var notes = _noteEditorController.text.trim();
    var success = await updateDealerVisit(checkinObject!, notes);
    if (success) {
      _backPressed();
    } else {
      _showErrorMessage("Something went wrong. Please try again", context);
    }
  }

  void _backPressed() {
    Navigator.of(context).pop();
  }

  void _showErrorMessage(String message, BuildContext context) {
    if (message.isNotEmpty) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> updateDealerVisit(ParseObject visit, String notes) async {
    visit..set('notes', notes)..set("checkoutAt", DateTime.now());
    print(visit);
    var checkinObject = await visit.save();
    if (checkinObject.success) {
      print("Success");
      return true;
    } else {
      print("Failure");
      print(checkinObject.error);
      return false;
    }
  }

  Future<ParseObject?> logDealerVisit(String imageUrl) async {
    final location = ParseGeoPoint(latitude: lat, longitude: lon);
    var currentUser = await ParseUser.currentUser() as ParseUser;

    final regObj = ParseObject('DealerVisits')
      ..set('visitImage', imageUrl)
      ..set('location', location)
      ..set(
          "userCreated", ParseObject('_User')..objectId = currentUser.objectId)
      ..set(
          "dealer",
          (ParseObject('Dealer')..objectId = selectedDealer.objectId)
              .toPointer());
    print(regObj);
    var checkinObject = await regObj.save();
    if (checkinObject.success) {
      print("Success");
      return checkinObject.result as ParseObject;
    } else {
      print("Failure");
      print(checkinObject.error);
      return null;
    }
  }

  var serverReceiverPath =
      "https://parseapi.kubitechsolutions.com/api/s3/image/upload";
  Future<String> uploadImage(filePath) async {
    var request = HTTP.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    request.files.add(await HTTP.MultipartFile.fromPath('file', filePath));
    var res = await request.send();
    print(res.statusCode);
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var responseJSON = JsonDecoder().convert(responseString);
    try {
      var url = responseJSON["response_data"]["Location"] as String;
      return url;
    } catch (error) {
      return "";
    }
  }
}
