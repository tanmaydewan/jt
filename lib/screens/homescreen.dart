import 'package:flutter/material.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading;
  late ParseUser currentUser;

  Future<ParseUser> getUser(BuildContext context) async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ParseUser>(
      future: getUser(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Container(
                  width: 100, height: 100, child: CircularProgressIndicator()),
            );
          default:
            return Scaffold(
              primary: true,
              appBar: EmptyAppBar(),
              body: _buildBody(),
            );
        }
      });

  Widget _buildBody() {
    return Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/home_back.jpeg"),
          fit: BoxFit.cover,
        )),
        child: _buildSubviews());
  }

  Widget _buildSubviews() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 24.0),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text("Welcome",
                                textAlign: TextAlign.left,
                                textScaleFactor: 3.0,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text("abhishek",
                                textAlign: TextAlign.left,
                                textScaleFactor: 2,
                                style: TextStyle(color: Colors.white))),
                        SizedBox(height: 60.0),
                        _optionsWidgetRow1(),
                        _optionsWidgetRow2()
                      ],
                    )),
              ),
            )));
  }

  Widget _optionsWidgetRow1() {
    return SizedBox(
        height: 150, // Some height
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => {_didTapRegisterEmployee(context)},
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      IconButton(
                          onPressed: null,
                          icon: Image.asset(
                            "assets/register_employee.jpeg",
                            height: 50,
                            width: 50,
                          )),
                      Text("Register Employee",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.black54))
                    ]))),
            Spacer(),
            GestureDetector(
                onTap: () => {_didTapRegisterDealer(context)},
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      IconButton(
                          onPressed: null,
                          icon: Image.asset(
                            "assets/register_dealer.jpeg",
                            height: 50,
                            width: 50,
                          )),
                      Text("Register Dealer",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.black54))
                    ])))
          ],
        ));
  }

  Widget _optionsWidgetRow2() {
    return SizedBox(
        height: 150, // Some height
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => {_didTapCheckinout(context)},
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      IconButton(
                          onPressed: null,
                          icon: Image.asset(
                            "assets/checkin_out.jpeg",
                            height: 50,
                            width: 50,
                          )),
                      Text("Checkin / Checkout",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.black54))
                    ]))),
          ],
        ));
  }

  void _didTapRegisterEmployee(BuildContext context) {
    // if (currentUser.isA)
  }

  void _didTapRegisterDealer(BuildContext context) {}

  void _didTapCheckinout(BuildContext context) {}

  void _showErrorMessage(String message, BuildContext context) {
    if (message.isNotEmpty) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
