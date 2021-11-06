import 'package:flutter/material.dart';
import 'package:just_in_time/list.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/screens/registration_Screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// ignore: must_be_immutable
class OptionsEmployee extends StatelessWidget {
  late ParseUser currentUser;

  Future<ParseUser> getUser(BuildContext context) async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ParseUser>(
      future: getUser(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Container(
                  width: 100, height: 100, child: CircularProgressIndicator()),
            );
          default:
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                    title: Center(
                        child: Text(
                      "JUST TIME",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                    automaticallyImplyLeading: false),
                body: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
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
                      child: OptionTile(
                        name: "Register Dealer",
                        colour: kColour,
                        ontapp: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Registration()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Expanded(
                      child: OptionTile(
                        name: "CheckIn/CheckOut",
                        colour: kColour,
                        ontapp: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Lst()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
        }
      });
}
