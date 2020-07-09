import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:flutter/material.dart';

class SuPage extends StatefulWidget {
  @override
  _SuPageState createState() => _SuPageState();
}

class _SuPageState extends State<SuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OkumaPage(kategori: "Su"),
    );
  }
}
