import 'package:flutter/material.dart';
import 'package:just_in_time/resources/checkInOut.dart';
import 'package:just_in_time/screens/Check_IN_OUT.dart';
import 'package:just_in_time/screens/searchScreen/searchsecond.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

var dealerName;
var longe;
var lati;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dealers Near You "),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: FutureBuilder<List<ParseObject>>(
            future: doUserQuery(),
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
                        final title = AppConstant.list[index]["title"];
                        final lat = AppConstant.list[index]["lat"];
                        final lon = AppConstant.list[index]["lon"];
                        //final userVerified = user.a) ?? false;
                        return GestureDetector(
                          onTap: () {
                            // searchsecond();
                            setState(() {
                              dealerName = AppConstant.list[index]["title"];
                              longe = AppConstant.list[index]["lon"];
                              lati = AppConstant.list[index]["lat"];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CheckInOut()));
                            });
                            print("title = $dealerName");
                          },
                          child: Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: ListTile(
                                title: Text(
                                  'Dealer Name: $title',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text("Location $lat $lon"),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
                  }
              }
            }));
  }

  Future<List<ParseObject>> doUserQuery() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    final ParseResponse apiResponse = await queryUsers.query();
    getMArk();
    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      print("printing elseeee");
      getMArk();
      return [];
    }
  }
}
