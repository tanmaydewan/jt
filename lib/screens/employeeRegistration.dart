import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_in_time/screens/homescreen.dart';
import 'package:just_in_time/utils/device_utils.dart';
import 'package:just_in_time/widgets/app_icon_widget.dart';
import 'package:just_in_time/widgets/empty_app_bar_widget.dart';
import 'package:just_in_time/widgets/progress_indicator_widget.dart';
import 'package:just_in_time/widgets/rounded_button_widget.dart';
import 'package:just_in_time/widgets/textfield_widget.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EmployeRegistration extends StatefulWidget {
  @override
  _EmployeRegistration createState() => _EmployeRegistration();
}

class _EmployeRegistration extends State<EmployeRegistration> {
  final controllerUsername = TextEditingController();

  final controllerPassword = TextEditingController();

  final controllerEmail = TextEditingController();

  var _isLoading;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
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
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : Center(child: _buildRightSide()),
          Visibility(
            visible: _isLoading,
            child: CustomProgressIndicatorWidget(),
          )
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconWidget(image: 'assets/ic_logo.png'),
            SizedBox(height: 64.0),
            _buildUserName(),
            _buildUserEmail(),
            _buildPasswordField(),
            SizedBox(height: 24.0),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Enter Username',
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: Colors
              .black54, //_themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: controllerUsername,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorText: null,
        );
      },
    );
  }

  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Enter Email',
          inputType: TextInputType.emailAddress,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.black54,
          textController: controllerEmail,
          errorText: null,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Enter password',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.black54,
          textController: controllerPassword,
          errorText: null,
        );
      },
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: 'Sign Up',
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () {
        if (_canSignUp()) {
          DeviceUtils.hideKeyboard(context);
          doUserRegistration();
        } else {
          _showErrorMessage('Please fill in all fields', context);
        }
      },
    );
  }

  void showSuccess(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

  bool _canSignUp() {
    var username = controllerUsername.text.trim();
    var email = controllerEmail.text.trim();
    var password = controllerPassword.text.trim();
    if (email.length == 0 || password.length == 0 || username.length == 0) {
      return false;
    }
    return true;
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.save();

    if (response.success) {
      // AlertDialog(
      //   title: const Text('Successfull'),
      //   content: Text("User created successfull"),
      //   actions: <Widget>[
      //     TextButton(
      //       child: const Text('Ok'),
      //       onPressed: () {
      //         _navigateToNextScreen(context);
      //       },
      //     ),
      //   ],
      // );
      _navigateToNextScreen(context);
      print("User created");
    } else {
      _showErrorMessage(response.error!.message, context);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
