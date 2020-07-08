import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/ui/AddScreen/Screen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrtakFloatActionButton extends StatefulWidget {
  final String kategori;
  const OrtakFloatActionButton({Key key, @required this.kategori})
      : super(key: key);

  @override
  _OrtakFloatActionButtonState createState() => _OrtakFloatActionButtonState();
}

class _OrtakFloatActionButtonState extends State<OrtakFloatActionButton> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Stack(
      children: <Widget>[
        FloatingActionButton(
          child: Icon(Icons.note_add),
          mini: true,
          heroTag: _userModel.makbuzID(_userModel.user.uid, widget.kategori),
          elevation: 5,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddScreen(
                  user: _userModel.user,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
