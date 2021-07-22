import 'package:flutter/material.dart';
import 'package:just_in_time/screens/home.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final controllerDealerName = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerLocation = TextEditingController();
  final controllerPincode = TextEditingController();
  final controllerTaxNumber = TextEditingController();



  void doUserRegistration() async {
     await saveReg(controllerDealerName.text,controllerAddress.text,controllerLocation.text,controllerPincode.text,controllerTaxNumber.text);
     
    setState(() {
      controllerDealerName.clear();
      controllerAddress.clear();
      controllerLocation.clear();
      controllerPincode.clear();
      controllerTaxNumber.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            child: new ListView(
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.image_aspect_ratio_rounded,
                          size: 40,
                        )
                        // FlutterLogo(
                        //   size: 100.0,
                        // ),
                      ],
                    )),
                Container(
                  child: TextField(
                    controller: controllerDealerName,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Dealer Name',
                      icon: new Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: controllerAddress,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Address',
                      icon: new Icon(Icons.home_max_rounded),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: controllerLocation,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Location',
                      icon: new Icon(Icons.location_history),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: controllerPincode,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Pincocde',
                      icon: new Icon(Icons.pin_drop),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: controllerTaxNumber,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter Tax Number',
                      icon: new Icon(Icons.money_off_csred_rounded),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      width: 210.0,
                      color: Colors.grey.shade700,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: new ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade700)),
                        child: new Text(
                          'Register',
                          style: new TextStyle(color: Colors.white),
                        ),
                        onPressed: () => doUserRegistration(),
                        // color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

Future<void> saveReg(String dealerName, String address, String location, String pincode, String taxNumber) async {
    await Future.delayed(Duration(seconds: 1), () {});
    final regObj = ParseObject('Dealer')..set('name', dealerName)..set('address', address)..set('location',location)..set('pincode', pincode)..set('TaxNumber', taxNumber);
    await regObj.save();
  }