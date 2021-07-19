import 'package:flutter/material.dart';
import 'package:just_in_time/screens/ReuseOptionTile.dart';
import 'package:just_in_time/screens/home.dart';
import 'package:just_in_time/screens/register_screen.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Just Time"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OptionTile(
                  name: "Register Employee",
                  colour: Colors.cyan,
                  ontapp: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                OptionTile(
                  name: "Register Dealer",
                  colour: Colors.blueGrey,
                  ontapp: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
                  },
                ),
              ],
            ),
          ),
          OptionTile(
            name: "CheckIn/CheckOut",
            colour: Colors.pinkAccent,
            ontapp: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
