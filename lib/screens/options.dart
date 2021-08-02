import 'package:flutter/material.dart';
import 'package:just_in_time/list.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/screens/employeeRegistration.dart';
import 'package:just_in_time/screens/Check_IN_OUT.dart';
import 'package:just_in_time/screens/registration_Screen.dart';
import 'package:just_in_time/screens/search.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text(
              "JUST TIME",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                height: 370,
                width: 370,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/ic_logo.png"),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  OptionTile(
                    name: "Register Employee",
                    colour: kColour,
                    ontapp: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LogInScreen()));
                    },
                  ),
                  OptionTile(
                    name: "Register Dealer",
                    colour: kColour,
                    ontapp: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Registration()));
                    },
                  ),
                ],
              ),
            ),
            OptionTile(
              name: "CheckIn/CheckOut",
              colour: kColour,
              ontapp: () async {
                
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Lst()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
