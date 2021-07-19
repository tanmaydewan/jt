import 'package:flutter/material.dart';
import 'package:just_in_time/screens/options.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// ignore: must_be_immutable
class LogInScreen extends StatelessWidget {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/ic_logo.png"),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 30.0,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("SIGN IN",
                            style: TextStyle(
                              color: Color(0xFFFFBD73),
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            )),
                        // FlatButton(
                        //   color: Colors.black12,
                        //   textColor: Colors.white,
                        //   child: Text('Sign Up',
                        //       style: TextStyle(
                        //         color: Color(0xFFFFBD73),
                        //         fontWeight: FontWeight.bold,
                        //       )),
                        //   onPressed: () {
                        //     print('Pressed SignUP!');
                        //   },
                        // ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.alternate_email,
                              color: Color(0xFFFFBD73),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: controllerUsername,
                              enabled: !isLoggedIn,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "Email Address",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.lock,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            controller: controllerPassword,
                            enabled: !isLoggedIn,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        child: Container(
                          color: Color(0xFFFFBD73),
                          margin: EdgeInsets.only(top: 10.0),
                          width: double.maxFinite,
                          height: 80.0,
                          child: Center(
                            child: Text('LogIn',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                )),
                          ),
                        ),
                        onTap: () {
                          doUserLogin(context);

                          // _navigateToNextScreen(context);
                          // isLoggedIn ? null : () => doUserLogin();

                          // _navigateToNextScreen(context);

                          print('user does not exist');
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccess(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogin(BuildContext context) async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      _navigateToNextScreen(context);

      isLoggedIn = true;
    } else {
      // showError(response.error!.message);

      showError(response.error!.message, context);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Options()));
  }
}

// ignore: camel_case_types
class Login_Successfull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
