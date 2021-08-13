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
        backgroundColor: Colors.grey[300],
        key: _scaffoldKey,
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                  onPressed: () => _backPressed(),
                  icon: Image.asset(
                    "assets/back_icon.png",
                    height: 40,
                    width: 40,
                  )),
              SizedBox(
                width: 40,
              ),
              Text("Employee Details",
                  textAlign: TextAlign.left,
                  textScaleFactor: 2.5,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
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
                            child:
                                Text("Error...: ${snapshot.error.toString()}"),
                          );
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('None user found'),
                            );
                          }

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Container(
                                color: Colors.grey[300],
                                child: ListView.separated(
                                  padding: EdgeInsets.only(top: 10.0),
                                  itemCount: AppConstant.list.length,
                                  itemBuilder: (context, index) {
                                    final namee =
                                        AppConstant.listEmp[index]["username"];
                                    final img = AppConstant.listEmp[index]
                                            ["profileImage"] ??
                                        "https://avatars.githubusercontent.com/u/17007144?v=4";
                                    final roleCheck =
                                        AppConstant.listEmp[index]["admin"];
                                    final adminRole;
                                    if (roleCheck == true) {
                                      adminRole = "Admin";
                                    } else {
                                      adminRole = "Employee";
                                    }
                                    // final email = AppConstant.listEmp[index]["email"];
                                    //final userVerified = user.a) ?? false;
                                    return SizedBox(
                                        height: 100, // Some height
                                        child: Expanded(
                                            child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          //color: Colors.lightGreen,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                    radius: 55,
                                                    backgroundColor:
                                                        Colors.blueGrey[300],
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(namee,
                                                        textAlign:
                                                            TextAlign.left,
                                                        textScaleFactor: 1.7,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(adminRole,
                                                        textAlign:
                                                            TextAlign.left,
                                                        textScaleFactor: 1.5,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ]),
                                        )));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      color: Colors.grey[300],
                                    );
                                  },
                                ),
                              ),
                            ),
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
