import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:faturasakla/ui/widget/ortak_floatactionbutton.dart';
import 'package:flutter/material.dart';

class InternetPage extends StatefulWidget {
  @override
  _InternetPageState createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İnternet Makbuzlarım'),
      ),
      body: OkumaPage(kategori: "İnternet"),
      floatingActionButton: OrtakFloatActionButton(kategori: "İnternet"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
