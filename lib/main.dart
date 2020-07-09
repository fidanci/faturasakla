import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: child,
    );
  }

  Widget get child => MaterialApp(
        title: 'Fatura Sakla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage(),
      );
}
