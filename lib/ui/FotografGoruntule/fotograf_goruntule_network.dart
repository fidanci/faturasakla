import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FotografGoruntuleNetwork extends StatefulWidget {
  final String photoURL;

  const FotografGoruntuleNetwork({Key key, @required this.photoURL})
      : super(key: key);
  @override
  _FotografGoruntuleNetworkState createState() =>
      _FotografGoruntuleNetworkState();
}

class _FotografGoruntuleNetworkState extends State<FotografGoruntuleNetwork> {
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
    var photo = widget.photoURL;
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

  Widget fotografiGoruntule(String photo, context) => Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                image: NetworkImage(photo),
              ),
            ],
          ),
        ),
      );
}
