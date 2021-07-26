
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraCapture extends StatefulWidget {
  
  @override
  _CameraCaptureState createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
  
 XFile? _image;

 Future imgFromCamera() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.camera, imageQuality: 50
  );

  setState(() {
    _image = image;
  });
  
}  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}