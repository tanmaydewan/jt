import 'package:flutter/material.dart';
import 'package:just_in_time/screens/ReuseOptionTile.dart';

class Options extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Just Time"),),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OptionTile(name: "Register Employee", colour: Colors.cyan,
                 
                ),
                OptionTile(name: "Register Dealer", colour: Colors.blueGrey,
                ),              ],
            ),
          ),
          OptionTile(name: "CheckIn/CheckOut", colour: Colors.pinkAccent,
                            ),
        ],
        
      ),
    );
  }
}