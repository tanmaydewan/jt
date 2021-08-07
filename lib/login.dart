import 'package:flutter/material.dart';
import 'package:just_in_time/main.dart';
import 'package:just_in_time/resources/checkInOut.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/screens/optionsAdmin.dart';
import 'package:just_in_time/screens/optionsEmployee.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    super.initState();
    getMArk();
  }

  final controllerUsername = TextEditingController();

  final controllerPassword = TextEditingController();

  bool isLoggedIn = false;

  Future<bool> hasUserLogged() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
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
                SizedBox(
                  height: 90,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: kColour,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    )),
                // Text("SIGN IN",
                // textAlign: TextAlign.center,

                //     style: TextStyle(
                //       color: kColour,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 40,

                //     )),
                Expanded(
                  child: TextField(
                    controller: controllerUsername,
                    enabled: !isLoggedIn,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email),
                      fillColor: kColour,
                      hintText: "Email Address",
                    ),
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
                      icon: Icon(Icons.lock),
                      hoverColor: kColour,
                      hintText: "Password",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 210.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kColour)),
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () => doUserLogin(context),
                        // color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Dealer'));
    parseQuery.whereEqualTo("objectId", username);
    print("objectid  = = ==   $parseQuery");
    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      navigateToNextScreen(context);

      isLoggedIn = true;
    } else {
      // showError(response.error!.message);

      showError(response.error!.message, context);
    }
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    bool a = await adminCheck();
    if (a == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OptionsAdmin()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OptionsEmployee()));
    }
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

Future<bool> adminCheck() async {
  ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
  final a = currentUser["isAdmin"];
  return a;
}
