import 'package:flutter/material.dart';
import 'package:just_in_time/resources/fetchCurrentLocation.dart';
import 'package:just_in_time/screens/ReuseTile.dart';

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
     await saveReg(controllerDealerName.text,controllerAddress.text,controllerPincode.text,controllerTaxNumber.text);
     
    setState(() {
      controllerDealerName.clear();
      controllerAddress.clear();
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
      body:  Container(
          padding:  EdgeInsets.all(20.0),
          child:  Form(
            child:  ListView(
              children: <Widget>[
                
                
                RegTextContainer(tController:controllerDealerName, tIcon: Icons.person, tLabel: 'Enter Dealer Name'),
                RegTextContainer(tController:controllerAddress, tLabel: 'Enter Address',tIcon: Icons.home_max_rounded,),
                RegTextContainer(tController:controllerPincode, tIcon: Icons.pin_drop, tLabel: 'Enter Pincocde'),               
                RegTextContainer(tController:controllerTaxNumber, tIcon: Icons.money_off_csred_rounded, tLabel:'Enter Tax Number'),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Container(
                      height: 50.0,
                      width: 210.0,
                      color: Colors.grey.shade700,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child:  ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade700)),
                        child:  Text(
                          'Register',
                          style:  TextStyle(color: Colors.white),
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


