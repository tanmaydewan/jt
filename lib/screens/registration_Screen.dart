import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_in_time/resources/server_call.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/textfield_widget.dart';

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
  String encodedImage = "";

  String status = "";

  // _RegistrationState(this.status);

  // XFile? _image;
  // Future getImage() async {
  //   final image = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, imageQuality: 30);
  //   // imagePath =image;
  //   final bytes = File(image!.path).readAsBytesSync();
  //   encodedImage = base64.encode(bytes);

  //   List<int> stringBytes = utf8.encode(encodedImage);
  //   List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
  //   String? compressedString = utf8.decode(gzipBytes!, allowMalformed: true);
  //   print(compressedString);

  //   setState(() {
  //     _image = image;

  //     final bytes = File(image.path).readAsBytesSync();
  //     encodedImage = base64.encode(bytes);

  //     List<int> stringBytes = utf8.encode(encodedImage);
  //     List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
  //     String? compressedString = utf8.decode(gzipBytes!, allowMalformed: true);
  //     print(compressedString);
  //     encodedImage = compressedString;
  //   });
  // }

  File? file;
  var serverReceiverPath =
      "https://parseapi.kubitechsolutions.com/api/s3/image/upload";

  Future<String?> uploadImage(file) async {
    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    request.files.add(await http.MultipartFile.fromPath('file', file));
    var res = await request.send();
    print(res.statusCode);
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var responseJSON = JsonDecoder().convert(responseString);
    var url = responseJSON["response_data"]["Location"] as String;
    return url;
  }

  // _RegistrationState.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  // }

  XFile? _image;
  Future getImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    var res = await uploadImage(image!.path);
    print(res);

    // var file = await _downloadFile(url);
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
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: EmptyAppBar(),
  //     body: Container(
  //         padding: EdgeInsets.all(20.0),
  //         child: Form(
  //           child: ListView(
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 30,
  //               ),

  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Center(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         getImage();
  //                       },
  //                       child: CircleAvatar(
  //                         radius: 55,
  //                         backgroundColor: kColour,
  //                         child: _image != null
  //                             ? ClipRRect(
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 child: Image.file(
  //                                   File(_image!.path),
  //                                   width: 100,
  //                                   height: 100,
  //                                   fit: BoxFit.fitHeight,
  //                                 ),
  //                               )
  //                             : Container(
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.grey[200],
  //                                     borderRadius: BorderRadius.circular(50)),
  //                                 width: 100,
  //                                 height: 100,
  //                                 child: Center(
  //                                     child: Text(
  //                                   "Visiting Card",
  //                                   style: TextStyle(color: Colors.grey[800]),
  //                                 ))),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Center(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         getImage();
  //                       },
  //                       child: CircleAvatar(
  //                         radius: 55,
  //                         backgroundColor: kColour,
  //                         child: _image != null
  //                             ? ClipRRect(
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 child: Image.file(
  //                                   File(_image!.path),
  //                                   width: 100,
  //                                   height: 100,
  //                                   fit: BoxFit.fitHeight,
  //                                 ),
  //                               )
  //                             : Container(
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.grey[200],
  //                                     borderRadius: BorderRadius.circular(50)),
  //                                 width: 100,
  //                                 height: 100,
  //                                 child: Center(
  //                                     child: Text(
  //                                   "Shop Front",
  //                                   style: TextStyle(color: Colors.grey[800]),
  //                                 ))),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Container(
  //                     height: 50.0,
  //                     width: 210.0,
  //                     margin: const EdgeInsets.symmetric(
  //                         horizontal: 20.0, vertical: 40.0),
  //                     child: ElevatedButton(
  //                       style: ButtonStyle(
  //                           backgroundColor:
  //                               MaterialStateProperty.all(kColour)),
  //                       child: Text(
  //                         'Register',
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                       onPressed: () => doUserRegistration(),
  //                       // color: Colors.grey.shade700,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         )),
  //   );
  // }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Enter email',
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: Colors
              .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: controllerDealerName,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorText: null,
        );
      },
    );
  }
}
