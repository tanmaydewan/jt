import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_in_time/screens/checkinoutScreen.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:just_in_time/widgets/textfield_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class DealerSearchScreen extends StatefulWidget {
  @override
  _DealerSearchScreenState createState() => _DealerSearchScreenState();
}

class _DealerSearchScreenState extends State<DealerSearchScreen> {
  var _isLoading;
  var _isSearching;
  var _dealersLoaded;
  TextEditingController _dealerSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _isSearching = false;
      _dealersLoaded = false;
    });
    _getAllDealers();
    _dealerSearchController.addListener(() {
      _didChangeSearchText(_dealerSearchController.text);
    });
  }

  @override
  void dispose() {
    _dealerSearchController.dispose();
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
              _dealersLoaded
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
                          Text("Dealers",
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
              _buildSearchDealers(),
              _buildFullDealersList(),
              Visibility(
                visible: _isLoading,
                child: CustomProgressIndicatorWidget(),
              )
            ],
          )),
    );
  }

  Widget _buildDetails(List<ParseObject>? dealerList) {
    return (dealerList != null && dealerList.length == 0)
        ? Text("No dealers found")
        : Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Expanded(
                    child: ListView.separated(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: dealerList!.length,
                  itemBuilder: (context, index) {
                    final _dealer = dealerList[index];
                    //final userVerified = user.a) ?? false;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CheckinoutScreen(selectedDealer: _dealer)));
                      },
                      child: _buildDealerTile(_dealer),
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
              textController: _dealerSearchController,
              inputAction: TextInputAction.next,
              autoFocus: false,
              errorText: null,
            ));
      },
    );
  }

  Widget _buildSearchDealers() {
    if (_isSearching) {
      return (_dealersSearched != null)
          ? _buildDetails(_dealersSearched)
          : Text("Searching..",
              textAlign: TextAlign.left,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.black54));
    } else {
      return Column();
    }
  }

  Widget _buildFullDealersList() {
    if (!_isSearching) {
      return _dealersLoaded
          ? _buildDetails(_dealers)
          : Text("Please Wait..",
              textAlign: TextAlign.left,
              textScaleFactor: 2.0,
              style: TextStyle(color: Colors.black54));
    } else {
      return Column();
    }
  }

  Widget _buildDealerTile(ParseObject _dealer) {
    // var lat = _dealer.get<ParseGeoPoint>('location')!.latitude;
    // var lon = _dealer.get<ParseGeoPoint>('location')!.longitude;
    var name = _dealer['name'] as String;
    var address = _dealer['address'] as String;
    var dealerImage = _dealer['dealerImage'] as String?;
    return SizedBox(
        height: 120, // Some height
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              _getDeaerImage(dealerImage),
              SizedBox(width: 5.0),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Text(name,
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.5,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(address,
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.black54))
                  ]))
            ])));
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
  List<ParseObject>? _dealers;
  List<ParseObject>? _dealersSearched;
  // ParseObject? _selectedDealer;

  void _backPressed() {
    Navigator.of(context).pop();
  }

  void _didChangeSearchText(String newValue) async {
    if (newValue.length < 3) {
      setState(() {
        _isSearching = false;
        _dealersSearched = null;
      });
    } else {
      setState(() {
        _isSearching = true;
      });
      _getDealersForSearch(newValue);
    }
  }

  void _getDealersForSearch(String search) async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Dealer'));
    parseQuery.whereContains('name', search);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allDealers = apiResponse.results! as List<ParseObject>;
      setState(() {
        _dealersSearched = allDealers;
      });
    }
  }

  void _getAllDealers() async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Dealer'));
    parseQuery.setLimit(50);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      var allDealers = apiResponse.results! as List<ParseObject>;
      setState(() {
        _dealers = allDealers;
      });
    }
    setState(() {
      _isLoading = false;
      _dealersLoaded = true;
    });
  }
}
