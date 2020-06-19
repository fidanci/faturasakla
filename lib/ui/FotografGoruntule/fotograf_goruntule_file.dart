import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FotografGoruntule extends StatefulWidget {
  final File photo;
  const FotografGoruntule({Key key, @required this.photo}) : super(key: key);

  @override
  _FotografGoruntuleState createState() => _FotografGoruntuleState();
}

class _FotografGoruntuleState extends State<FotografGoruntule> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var photo = widget.photo;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return fotografiGoruntule(photo, context);
          } else {
            return fotografiGoruntule(photo, context);
          }
        },
      ),
    );
  }

  Widget fotografiGoruntule(File photo, context) => Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                image: FileImage(
                  File(photo.path),
                ),
              ),
            ],
          ),
        ),
      );
}
