import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:just_in_time/widgets/textfield_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EmployeeSearchScreen extends StatefulWidget {
  @override
  _EmployeeSearchScreenState createState() => _EmployeeSearchScreenState();
}

class _EmployeeSearchScreenState extends State<EmployeeSearchScreen> {
  var _isLoading;
  var _isSearching;
  var _employeeLoaded;
  TextEditingController _employeesearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _isSearching = false;
      _employeeLoaded = false;
    });
    _getAllemployee();
    _employeesearchController.addListener(() {
      _didChangeSearchText(_employeesearchController.text);
    });
  }

  @override
  void dispose() {
    _employeesearchController.dispose();
    super.dispose();
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
      child: Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24.0),
              _employeeLoaded
                  ? Row(
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
                          Text("Employee",
                              textAlign: TextAlign.left,
                              textScaleFactor: 2.0,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ])
                  : Column(),
              SizedBox(height: 5.0),
              _buildSearchField(),
              SizedBox(height: 20.0),
              _buildSearchemployee(),
              _buildFullemployeeList(),
              Visibility(
                visible: _isLoading,
                child: CustomProgressIndicatorWidget(),
              )
            ],
          )),
    );
  }

  Widget _buildDetails(List<ParseObject>? employeeList) {
    return (employeeList != null && employeeList.length == 0)
        ? Text("No employee found")
        : Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: employeeList!.length,
                  itemBuilder: (context, index) {
                    final _employee = employeeList[index];
                    //final userVerified = user.a) ?? false;
                    return GestureDetector(
                      onTap: () {},
                      child: _buildEmployeeTile(_employee),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ))
              ]));
  }

  Widget _buildSearchField() {
    return Observer(
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFieldWidget(
              hint: 'Search',
              icon: Icons.search,
              iconColor: Colors
                  .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
              textController: _employeesearchController,
              inputAction: TextInputAction.next,
              autoFocus: false,
              errorText: null,
            ));
      },
    );
  }

  Widget _buildSearchemployee() {
    if (_isSearching) {
      return (_employeeSearched != null)
          ? _buildDetails(_employeeSearched)
          : Text("Searching..",
              textAlign: TextAlign.left,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.black54));
    } else {
      return Column();
    }
  }

  Widget _buildFullemployeeList() {
    if (!_isSearching) {
      return _employeeLoaded
          ? _buildDetails(_employee)
          : Text("Please Wait..",
              textAlign: TextAlign.left,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.black54));
    } else {
      return Column();
    }
  }

  Widget _buildEmployeeTile(ParseObject _employee) {
    // var lat = _dealer.get<ParseGeoPoint>('location')!.latitude;
    // var lon = _dealer.get<ParseGeoPoint>('location')!.longitude;
    final namee = _employee["username"];
    final img = _employee["profileImg"] ??
        "https://avatars.githubusercontent.com/u/17007144?v=4";
    final roleCheck = _employee["admin"];
    var adminRole = "Employee";
    if (roleCheck == true) {
      adminRole = "Admin";
    }
    return SizedBox(
        height: 100, // Some height
        child: Expanded(
            child: Card(
                child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blueGrey[300],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        '$img',
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(namee,
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.4,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(adminRole,
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.black45)),
                  ],
                ),
              ]),
        ))));
  }

  Widget _getDeaerImage(String? dealerImage) {
    const palceholderAsset = 'assets/placeholder.png';
    return SizedBox(
        height: 80, // Some height
        child: dealerImage != null
            ? FadeInImage.assetNetwork(
                placeholder: palceholderAsset, image: dealerImage)
            : Image.asset(palceholderAsset));
  }

  var lat, lon;
  List<ParseObject>? _employee;
  List<ParseObject>? _employeeSearched;
  // ParseObject? _selectedDealer;

  void _backPressed() {
    Navigator.of(context).pop();
  }

  void _didChangeSearchText(String newValue) async {
    if (newValue.length < 3) {
      setState(() {
        _isSearching = false;
        _employeeSearched = null;
      });
    } else {
      setState(() {
        _isSearching = true;
      });
      _getemployeeForSearch(newValue);
    }
  }

  void _getemployeeForSearch(String search) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    parseQuery..whereContains('username', search);
    // ..whereContains('email', search)
    // ..whereContains('adhaarNumber', search);
    // parseQuery.whereContains('email', search);
    // parseQuery.whereContains('adhaarNumber', search);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allemployee = apiResponse.results! as List<ParseObject>;
      setState(() {
        _employeeSearched = allemployee;
      });
    }
  }

  void _getAllemployee() async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    parseQuery.setLimit(50);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allemployee = apiResponse.results! as List<ParseObject>;
      setState(() {
        _employee = allemployee;
      });
    }
    setState(() {
      _isLoading = false;
      _employeeLoaded = true;
    });
  }
}
