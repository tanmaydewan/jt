import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(selectedEmployee: this.selectedEmployee);
  const ProfileScreen({Key? key, required this.selectedEmployee})
      : super(key: key);

  // Declare a field that holds the Todo.
  final ParseObject selectedEmployee;
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState({required this.selectedEmployee}) : super();


  final ParseObject selectedEmployee;
  List<ParseObject>? _checkins;
  var _isLoading;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _getCheckins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: Stack(
        children: <Widget>[
          _buildCoverImage(),
          _logoutWidget(),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  _buildProfileImage(),
                  _buildProfileDetail(),
                  _buildCheckinList(),
                  Visibility(
                    visible: _isLoading,
                    child: CustomProgressIndicatorWidget(),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
      ),
    );
  }

  Widget _logoutWidget() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
          onTap: () => {_backPressed()},
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text("Back",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                        style: TextStyle(color: Colors.black54))
                  ]))))
    ]);
  }

  Widget _buildProfileImage() {
    var image = selectedEmployee["profileImg"] ??
        "https://img.icons8.com/cotton/2x/gender-neutral-user--v2.png";
    return Center(
      child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 4.0,
            ),
          ),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(image))),
    );
  }

  Widget _buildProfileDetail() {
    final name = selectedEmployee["username"];
    final email = selectedEmployee["email"] ?? "";
    final roleCheck = selectedEmployee["admin"];
    var adminRole = "Employee";
    if (roleCheck == true) {
      adminRole = "Admin";
    }
    return Center(
        child: Container(
            width: 200.0,
            height: 80.0,
            decoration: BoxDecoration(color: Colors.transparent),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(name,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.4,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text(adminRole,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black45)),
              Text(email,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.1,
                  style: TextStyle(color: Colors.black45))
            ])));
  }

  Widget _buildCheckinList() {
    if (_checkins != null) {
      return Expanded(
          child: ListView.separated(
        padding: EdgeInsets.only(top: 10.0),
        itemCount: _checkins!.length,
        itemBuilder: (context, index) {
          final _checkin = _checkins![index];
          //final userVerified = user.a) ?? false;
          return _buildCheckinTile(_checkin);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ));
    } else {
      return Column();
    }
  }

  Widget _buildCheckinTile(ParseObject _checkin) {
    var checkinObj = _checkin['createdAt'];
    var checkoutObj = _checkin['checkoutAt'];
    String checkin = DateFormat('dd MMM HH:mm a').format(checkinObj);
    String checkout = "--";
    if (checkoutObj != null) {
      checkout = DateFormat('dd MMM HH:mm a').format(checkoutObj);
    }
    var dealer = _checkin.get<ParseObject>('dealer');
    final dealerName = dealer!['name'] as String;
    final dealerAddress = dealer['address'] as String;

    var notes = _checkin['notes'] ?? "";
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(mainAxisSize: MainAxisSize.max, children: [
              Text(dealerName,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.black87))
            ]),
            Row(mainAxisSize: MainAxisSize.max, children: [
              Container(
                  width: 250,
                  child: Text(dealerAddress,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      textScaleFactor: 0.8,
                      style: TextStyle(color: Colors.black45)))
            ]),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Checkin    :",
                    textAlign: TextAlign.left,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black)),
                Text(checkin,
                    textAlign: TextAlign.left,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black45))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Checkout   :",
                    textAlign: TextAlign.left,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black)),
                Text(checkout,
                    textAlign: TextAlign.left,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black45))
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Notes   :",
                    textAlign: TextAlign.left,
                    textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black54)),
                Container(
                    width: 250,
                    child: Text(notes,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.fade,
                        textScaleFactor: 0.8,
                        style: TextStyle(color: Colors.black45))),
                Spacer()
              ],
            )
          ],
        ));
  }

  void _backPressed() {
    Navigator.of(context).pop();
  }

  void _getCheckins() async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('DealerVisits'));
    parseQuery
      ..whereEqualTo("userCreated", selectedEmployee.toPointer())
      ..includeObject(['dealer', 'dealer.name', 'dealer.address']);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allCheckins = apiResponse.results! as List<ParseObject>;
      setState(() {
        _checkins = allCheckins;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }
}
