import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:archive/archive.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late final imagePath;
  String encodedImage="";
  
  XFile? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50);
    // imagePath =image;
    final bytes = File(image!.path).readAsBytesSync();
    encodedImage = base64.encode(bytes);
  
    List<int> stringBytes = utf8.encode(encodedImage);
List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
String? compressedString = utf8.decode(gzipBytes!, allowMalformed: true);
print(compressedString);

    setState(() {
      _image = image;
      // encodedImage =  base64.encode(bytes);
       //print(encodedImage);

       final bytes = File(image.path).readAsBytesSync();
    encodedImage = base64.encode(bytes);
  
    List<int> stringBytes = utf8.encode(encodedImage);
List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
String? compressedString = utf8.decode(gzipBytes!, allowMalformed: true);
print(compressedString);
encodedImage=compressedString;
     
    });
  }

  void doUserRegistration() async {
    await saveReg(controllerDealerName.text, controllerAddress.text,
        controllerPincode.text, controllerTaxNumber.text, encodedImage);

    setState(() {
      controllerDealerName.clear();
      controllerAddress.clear();
      controllerPincode.clear();
      controllerTaxNumber.clear();
      _image = null;
    });
  }

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
                RegTextContainer(
                    tController: controllerDealerName,
                    tIcon: Icons.person,
                    tLabel: 'Enter Dealer Name'),
                RegTextContainer(
                  tController: controllerAddress,
                  tLabel: 'Enter Address',
                  tIcon: Icons.home_max_rounded,
                ),
                RegTextContainer(
                    tController: controllerPincode,
                    tIcon: Icons.pin_drop,
                    tLabel: 'Enter Pincocde'),
                RegTextContainer(
                    tController: controllerTaxNumber,
                    tIcon: Icons.money_off_csred_rounded,
                    tLabel: 'Enter Tax Number'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xffFDCF09),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    File(_image!.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
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
