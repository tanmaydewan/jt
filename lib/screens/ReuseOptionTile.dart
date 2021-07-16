import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  OptionTile({required this.name, required this.colour  });
  final String name;
  final Color colour;
  
  
  @override
  Widget build(BuildContext context) {
     return Expanded(
       child: 
       Container(
      margin: EdgeInsets.all(20),
      child: Center(child: Text(name)),
      color: colour,
       ),
       );
  }
}
