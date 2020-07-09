import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:flutter/material.dart';

class InternetPage extends StatefulWidget {
  @override
  _InternetPageState createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OkumaPage(kategori: "İnternet"),
    );
  }
}
