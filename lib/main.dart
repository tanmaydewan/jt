import 'package:flutter/material.dart';
import 'package:just_in_time/login.dart';
import 'package:just_in_time/screens/options.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFFBD73);

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: Options(),
    );
  }
}
