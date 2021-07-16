import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  OptionTile({required this.name, required this.colour, required this.ontapp });
  final String name;
  final Color colour;
  final ontapp; 
  
  @override
  Widget build(BuildContext context) {
     return Expanded(
       child: GestureDetector(
         onTap: ontapp,
         child: Expanded(
           child: 
           Container(
          margin: EdgeInsets.all(20),
          child: Center(child: Text(name)),
          color: colour,
           ),
           ),
       ),
     );
  }
}
