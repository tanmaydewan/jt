import 'package:flutter/material.dart';
import 'package:just_in_time/screens/options.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

<<<<<<< HEAD
class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
=======
// ignore: must_be_immutable
class EmployeeRegistration extends StatefulWidget {
>>>>>>> ee5a88f32248940a199e52faa87c41464c7bc794
  final controllerUsername = TextEditingController();

  final controllerPassword = TextEditingController();

<<<<<<< HEAD
  final controllerEmail = TextEditingController();

=======
>>>>>>> ee5a88f32248940a199e52faa87c41464c7bc794
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
                        Text("SIGN UP",
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
                              Icons.person,
                              color: Color(0xFFFFBD73),
                            ),
                          ),
                          
                          Expanded(
                            child: TextField(
                              controller: controllerUsername,
                              //enabled: !isLoggedIn,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "Enter Username",
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
                            Icons.alternate_email,
                            color: Color(0xFFFFBD73),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            controller: controllerEmail,
                           // enabled: !isLoggedIn,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                            ),
                          ),
                        ),
                      ],
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
                            //enabled: !isLoggedIn,
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
                          //doUserLogin(context);
                          doUserRegistration();
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

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Options()));
      _navigateToNextScreen(context);
      print("User created");
    } else {
      showError(response.error!.message, context);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Options()));
  }
}
