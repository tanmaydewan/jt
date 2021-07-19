import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Registration'),
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
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                        decoration: new InputDecoration(
                      labelText: 'Enter Dealer Name',
                      icon: new Icon(Icons.person),
                    ))),
                new Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TextFormField(
                        decoration: new InputDecoration(
                            labelText: 'Enter Address',
                            icon: new Icon(Icons.home_max_rounded)))),
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Enter Location',
                          icon: new Icon(Icons.location_history))),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Enter Pincode',
                          icon: new Icon(Icons.pin_drop))),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Enter Tax Number',
                          icon: new Icon(Icons.money_off_csred_rounded))),
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

  // _performLogin() {

  // }

  // _navigateRegistration() {
  //   NavigationRouter.switchToRegistration(context);
  // }
}
