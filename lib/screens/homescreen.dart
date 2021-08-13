import 'package:flutter/material.dart';
import 'package:just_in_time/login.dart';
import 'package:just_in_time/screens/dealerSearch.dart';
import 'package:just_in_time/screens/employeeRegistration.dart';
import 'package:just_in_time/screens/nearbyDealers.dart';
import 'package:just_in_time/screens/registration_Screen.dart';
import 'package:just_in_time/screens/searchScreen/searchEmployee.dart';
import 'package:just_in_time/screens/searchScreen/searchsecond.dart';
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

  bool isAdmin() {
    final a = currentUser["isAdmin"];
    return a;
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
                            child: Text(currentUser.username ?? "abhishek",
                                textAlign: TextAlign.left,
                                textScaleFactor: 2,
                                style: TextStyle(color: Colors.white))),
                        _optionsWidgetRow3(),
                        SizedBox(height: 60.0),
                        _optionsWidgetRow1(),
                        _optionsWidgetRow2(),
                      ],
                    )),
              ),
            )));
  }

  Widget _optionsWidgetRow1() {
    return SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => {_didTapRegisterEmployee(context)},
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                            ])))),
            Spacer(),
            GestureDetector(
                onTap: () => {_didTapRegisterDealer(context)},
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                              Text("Register Dealer  ",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: Colors.black54))
                            ]))))
          ],
        ));
  }

  Widget _optionsWidgetRow2() {
    return SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => {_didTapCheckinout(context)},
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                            ])))),
            Spacer(),
            GestureDetector(
                onTap: () => {_didTapOnSearchDealer(context)},
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                  onPressed: null,
                                  icon: Image.asset(
                                    "assets/search_icon.png",
                                    height: 50,
                                    width: 50,
                                  )),
                              Text("Search Dealer",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: Colors.black54))
                            ]))))
          ],
        ));
  }

  Widget _optionsWidgetRow3() {
    return SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => {_doUserLogout(context)},
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // IconButton(
                              //     onPressed: null,
                              //     icon: Image.asset(
                              //       "assets/checkin_out.jpeg",
                              //       height: 50,
                              //       width: 50,
                              //     )),
                              Text("Logout",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(color: Colors.black54))
                            ])))),
          ],
        ));
  }

  void _doUserLogout(BuildContext context) async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      print("logout successfull");
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new LogInScreen()));
      setState(() {
        var isLoggedIn = false;
      });
    } else {
      print("logout unseccessful");
    }
  }

  void _didTapRegisterEmployee(BuildContext context) {
    if (isAdmin()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EmployeRegistration()));
    } else {
      _showErrorMessage(
          "Only admin can create employee. Please contact Support", context);
    }
  }

  void _didTapRegisterDealer(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Registration()));
  }

  void _didTapCheckinout(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NearbyDealersScreen()));
  }

  void _didTapOnSearchDealer(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DealerSearchScreen()));
  }

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
