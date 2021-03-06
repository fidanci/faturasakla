import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/ui/home/screen/homescreen.dart';
import 'package:faturasakla/ui/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignIn();
      } else {
        return HomePage();
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
