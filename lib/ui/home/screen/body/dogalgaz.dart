import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:faturasakla/ui/widget/ortak_floatactionbutton.dart';
import 'package:flutter/material.dart';

class DogalGazPage extends StatefulWidget {
  @override
  _DogalGazPageState createState() => _DogalGazPageState();
}

class _DogalGazPageState extends State<DogalGazPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doğalgaz Makbuzlarım'),
      ),
      body: OkumaPage(kategori: "Doğalgaz"),
      floatingActionButton: OrtakFloatActionButton(kategori: "Doğalgaz"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
