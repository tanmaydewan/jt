import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  OptionTile({required this.name, required this.colour, required this.ontapp});
  final String name;
  final Color colour;
  final ontapp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: ontapp,
        child: Expanded(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight:FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  TextContainer({required this.tLabel, required this.tIcon});

  final String tLabel;
  final IconData tIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: tLabel,
          icon: Icon(tIcon),
        ),
      ),
    );
  }
}

class RegTextContainer extends StatelessWidget {
  const RegTextContainer(
      {Key? key,
      required this.tController,
      required this.tIcon,
      required this.tLabel});

  final TextEditingController tController;
  final String tLabel;
  final IconData tIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: tController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: tLabel,
          icon: Icon(tIcon),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
