import 'package:faturasakla/ui/home/screen/body/okuma.dart';
import 'package:flutter/material.dart';

class DogalGazPage extends StatefulWidget {
  @override
  _DogalGazPageState createState() => _DogalGazPageState();
}

class _DogalGazPageState extends State<DogalGazPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OkumaPage(kategori: "Doğalgaz"),
    );
  }
}
