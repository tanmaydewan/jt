import 'package:flutter/material.dart';
import 'package:just_in_time/resources/checkInOut.dart';
import 'package:just_in_time/screens/Check_IN_OUT.dart';
import 'package:just_in_time/screens/homescreen.dart';
import 'package:just_in_time/screens/searchScreen/searchsecond.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

var employeeName;

class SearchEmployee extends StatefulWidget {
  @override
  _SearchEmployee createState() => _SearchEmployee();
}

class _SearchEmployee extends State<SearchEmployee> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        key: _scaffoldKey,
        body: Column(
          children: [
            SizedBox(height: 30,),
            Row(
                      
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          IconButton(
                              onPressed: () => _backPressed(),
                              icon: Image.asset(
                                "assets/back_icon.png",
                                height: 40,
                                width: 40,
                              )),
                          Text("Employee Details",
                              textAlign: TextAlign.left,
                              textScaleFactor: 2.0,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ]),
            Expanded(
              child: FutureBuilder<List<ParseObject>>(
                  future: getEmployee(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error...: ${snapshot.error.toString()}"),
                          );
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('None user found'),
                            );
                          }
            
                          return ListView.separated(
                            padding: EdgeInsets.only(top: 10.0),
                            itemCount: AppConstant.list.length,
                            itemBuilder: (context, index) {
                              final namee = AppConstant.listEmp[index]["username"];
                              final email = AppConstant.listEmp[index]["email"];
                              //final userVerified = user.a) ?? false;
                              return SizedBox(
                                  height: 100, // Some height
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                            Text(namee,
                                                textAlign: TextAlign.left,
                                                textScaleFactor: 1.5,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                             Text(email,
                                                textAlign: TextAlign.left,
                                                textScaleFactor: 1.5,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                          ])))
                                          );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider();
                            },
                          );
                        }
                    }
                  }),
            ),
          ],
        ));
  }

  Future<List<ParseObject>> getEmployee() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
        
    final ParseResponse apiResponse = await queryUsers.query();
    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
   void _backPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
