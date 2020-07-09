import 'package:flutter/material.dart';
import 'package:faturasakla/ui/home/screen/body/okuma.dart';

class ElektrikPage extends StatefulWidget {
  @override
  _ElektrikPageState createState() => _ElektrikPageState();
}

class _ElektrikPageState extends State<ElektrikPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OkumaPage(kategori: "Elektrik"),
    );
  }
}
