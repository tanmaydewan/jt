import 'package:flutter/material.dart';
import 'package:just_in_time/login.dart';
import 'package:just_in_time/screens/options.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFF5A5656);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'jtadmin';
  final keyClientKey = 'JTMasterKeyUnique';
  final keyParseServerUrl = 'https://parseapi.kubitechsolutions.com/admin';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    //Validates that the user's session token is valid
    ParseResponse? userResponse = await ParseUser.getCurrentUserFromServer(
        currentUser.get('sessionToken'));

    if (!userResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      // home: LogInScreen(),
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
                break;
              default:
                if (snapshot.hasData) {
                  return Options();
                } else {
                  return LogInScreen();
                }
            }
          }),
    );
  }
}
