import 'package:flutter/material.dart';
import 'package:just_in_time/resources/checkInOut.dart';
import 'package:just_in_time/screens/Check_IN_OUT.dart';
import 'package:just_in_time/screens/searchScreen/dealerSearch.dart';
import 'package:just_in_time/screens/searchScreen/searchEmployee.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SearchSecond extends StatefulWidget {
  @override
  _SearchSecondState createState() => _SearchSecondState();
}

class _SearchSecondState extends State<SearchSecond> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [DealerSearch(), SearchEmployee()],
          ),
        ),
      ),
    );
  }
}
