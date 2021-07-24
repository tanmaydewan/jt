import 'package:flutter/material.dart';
import 'package:just_in_time/screens/ReuseTile.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image_aspect_ratio_rounded,
                        size: 40,
                      )
                      
                    ],
                  ),
                ),
                TextContainer(tLabel:'Enter Dealer Name' , tIcon: Icons.person ),
                TextContainer(tLabel: 'Enter Address', tIcon:Icons.home_max_rounded),
                TextContainer(tLabel: 'Enter Pincode', tIcon: Icons.pin_drop),
                TextContainer(tLabel: 'Enter Tax Number', tIcon:Icons.money_off_csred_rounded),
                
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 210.0,
                      color: Colors.grey.shade700,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade700)),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => print("registered"),
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

