import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:faturasakla/ui/widget/ortak_floatactionbutton.dart';
import 'package:flutter/material.dart';

class SuPage extends StatefulWidget {
  @override
  _SuPageState createState() => _SuPageState();
}

class _SuPageState extends State<SuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Su Makbuzlarım'),
      ),
      body: OkumaPage(kategori: "Su"),
      floatingActionButton: OrtakFloatActionButton(
        kategori: "Su",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
