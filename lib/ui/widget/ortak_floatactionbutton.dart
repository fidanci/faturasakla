import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/ui/AddScreen/Screen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrtakFloatActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('Makbuz Ekle'),
      onPressed: () {
        UserModel _userModel = Provider.of<UserModel>(context, listen: false);
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => AddScreen(
              currentUser: _userModel.user,
            ),
          ),
        );
      },
    );
  }
}
