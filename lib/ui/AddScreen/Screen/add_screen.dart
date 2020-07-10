import 'dart:io';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';
import 'package:faturasakla/ui/FotografGoruntule/fotograf_goruntule_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  final User user;

  const AddScreen({Key key, @required this.user}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File _image;
  var imagePicker = ImagePicker();
  Timestamp baslik = Timestamp.now();
  String dropdownValue = 'Elektrik';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddScreen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_image != null) {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                FotografGoruntule(photo: _image),
                          ),
                        );
                      }
                    },
                    child: _image == null
                        ? GestureDetector(
                            child: Text('Lütfen bir makbuz fotoğrafı çekin '),
                            onTap: () {
                              print("kamera'dan fotoğraf çekiliyor");
                              getImage();
                            },
                          )
                        : Image.file(
                            _image,
                            height: MediaQuery.of(context).size.height * 1 / 3,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.expand_more),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Doğalgaz', 'Elektrik', 'İnternet', 'Su']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                RaisedButton.icon(
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Makbuzu Kaydet',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => makbuzKaydet(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void makbuzKaydet(BuildContext context) async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    var _photoURL =
        await _userModel.uploadFile(widget.user, _image, dropdownValue);
    Makbuz makbuz = Makbuz(
        baslik: baslik.toDate(),
        photoURL: _photoURL.toString(),
        user: widget.user.uid);
    if (_image != null) {
      var sonuc =
          await _userModel.makbuzKaydet(makbuz, widget.user.uid, dropdownValue);
      if (sonuc == true) {
        print("$dropdownValue makbuzu kaydedildi");
        Navigator.of(context).pop();
        showAchievementView(
          context,
          "Makbuzunuz Kaydedildi",
          baslik.toDate().toString().substring(0, 16),
          Image.file(_image),
          Colors.blue,
        );
      } else {
        print("$dropdownValue makbuzunda hata");
        Navigator.of(context).pop();
        showAchievementView(
          context,
          "Hata",
          "Sunucu kaynaklı bir hatadan ötürü makbuz yükelenemedi' Lütfen tekrar deneyiniz!",
          Icon(Icons.close),
          Colors.red,
        );
      }
    }
  }

  void showAchievementView(BuildContext context, String title, String subTitle,
      Widget icon, Color color) {
    AchievementView(
      context,
      title: title,
      subTitle: subTitle,
      //onTab: _onTabAchievement,
      icon: icon,
      typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      borderRadius: 5.0,
      color: color,
      textStyleTitle: TextStyle(),
      textStyleSubTitle: TextStyle(),
      alignment: Alignment.topCenter,
      duration: Duration(seconds: 3),
      //isCircle: false,
      listener: (status) {
        print(status);
        //AchievementState.opening
        //AchievementState.open
        //AchievementState.closing
        //AchievementState.closed
      },
    )..show();
  }
}
