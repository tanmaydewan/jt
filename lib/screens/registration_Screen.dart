import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_in_time/resources/server_call.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/rounded_button_widget.dart';
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
    try {
      var url = responseJSON["response_data"]["Location"] as String;
      return url;
    } catch (error) {
      return "";
    }
  }

  // _RegistrationState.fromJson(Map<String, dynamic> json) {

  String? _selectedImageUrl;
  XFile? _image;
  Future getImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    var res = await uploadImage(image!.path);
    print(res);
    setState(() {
      _selectedImageUrl = res;
      _image = image;
    });
    // var file = await _downloadFile(url);
  }

  void doUserRegistration() async {
    var imageUrl = _selectedImageUrl != null ? _selectedImageUrl! : "";
    await saveReg(controllerDealerName.text, controllerAddress.text,
        controllerPincode.text, controllerTaxNumber.text, imageUrl);

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

  Widget _buildBody() {
    return Material(
        child: Row(children: <Widget>[
      Expanded(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(height: 24.0),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => _backPressed(),
                            icon: Image.asset(
                              "assets/back_icon.png",
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Register Dealer",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2.0,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ]),
                  SizedBox(
                    height: 35,
                  ),
                  _buildDealerName(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildDealerAdress(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildDealerPincode(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildTaxNumber(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildImage(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRegisterDealerDetailButton()
                ],
              ))),
    ]));
  }

  Widget _buildDealerName() {
    // return Observer(
    //   builder: (context) {
    return TextFieldWidget(
      hint: 'Enter Deale Name',
      inputType: TextInputType.emailAddress,
      icon: Icons.person,
      iconColor: Colors
          .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
      textController: controllerDealerName,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorText: null,
    );
    //   },
    // );
  }

  Widget _buildDealerAdress() {
    return TextFieldWidget(
      hint: 'Enter Adress',
      inputType: TextInputType.emailAddress,
      icon: Icons.email,
      iconColor: Colors
          .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
      textController: controllerAddress,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorText: null,
    );
  }

  Widget _buildDealerPincode() {
    return TextFieldWidget(
      hint: 'Enter Pincode',
      inputType: TextInputType.emailAddress,
      icon: Icons.pin_drop_outlined,
      iconColor: Colors
          .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
      textController: controllerPincode,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorText: null,
    );
    //   },
    // );t
  }

  Widget _buildTaxNumber() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Enter Tax Number',
          inputType: TextInputType.emailAddress,
          icon: Icons.attach_money_outlined,
          iconColor: Colors
              .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: controllerTaxNumber,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorText: null,
        );
      },
    );
  }

  Widget _buildImage() {
    return Observer(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  getImage();
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: kColour,
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
                          child: Center(
                              child: Text(
                            "Visiting Card",
                            style: TextStyle(color: Colors.grey[800]),
                          ))),
                ),
              ),
            ),
            //
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       getImage();
            //     },
            //     child: CircleAvatar(
            //       radius: 55,
            //       backgroundColor: kColour,
            //       child: _image != null
            //           ? ClipRRect(
            //               borderRadius: BorderRadius.circular(50),
            //               child: Image.file(
            //                 File(_image!.path),
            //                 width: 100,
            //                 height: 100,
            //                 fit: BoxFit.fitHeight,
            //               ),
            //             )
            //           : Container(
            //               decoration: BoxDecoration(
            //                   color: Colors.grey[200],
            //                   borderRadius: BorderRadius.circular(50)),
            //               width: 100,
            //               height: 100,
            //               child: Center(
            //                   child: Text(
            //                 "Shop Front",
            //                 style: TextStyle(color: Colors.grey[800]),
            //               ))),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  Widget _buildRegisterDealerDetailButton() {
    return RoundedButtonWidget(
      buttonText: 'Register Detail',
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () {
        doUserRegistration();
        _backPressed();
      },
    );
  }

  void _backPressed() {
    Navigator.of(context).pop();
  }
}
