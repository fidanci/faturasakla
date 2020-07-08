import 'package:faturasakla/ui/widget/ortak_floatactionbutton.dart';
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
      appBar: AppBar(
        title: Text('Elektrik Makbuzlarım'),
      ),
      body: OkumaPage(kategori: "Elektrik"),
      floatingActionButton: OrtakFloatActionButton(kategori: "Elektrik"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
