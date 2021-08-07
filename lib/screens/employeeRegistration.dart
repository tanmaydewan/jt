import 'package:flutter/material.dart';
import 'package:just_in_time/screens/ReuseTile.dart';
import 'package:just_in_time/screens/optionsAdmin.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final controllerUsername = TextEditingController();

  final controllerPassword = TextEditingController();

  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text(
              "Employee Registration",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            automaticallyImplyLeading: false),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
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
            SizedBox(
              height: 30,
            ),
                RegTextContainer(
             tController: controllerUsername,
             tIcon: Icons.person,
             tLabel: 'Enter Username'),
                RegTextContainer(
           tController: controllerEmail,
           tLabel: 'Enter Email',
           tIcon: Icons.email,
                ),
                RegTextContainer(
             tController: controllerPassword,
             tIcon: Icons.lock,
             tLabel: 'Password'),
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
                     backgroundColor: MaterialStateProperty.all(
                         kColour)),
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

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OptionsAdmin()));
      _navigateToNextScreen(context);
      print("User created");
    } else {
      showError(response.error!.message, context);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OptionsAdmin()));
  }
}
