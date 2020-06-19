import 'dart:io';
import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/ui/FotografGoruntule/fotograf_goruntule_file.dart';
import 'package:faturasakla/ui/widget/platform_duyarli_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  final User currentUser;

  const AddScreen({Key key, this.currentUser}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File _image;
  final picker = ImagePicker();
  String dropdownValue = 'Elektrik';
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
                    child: Image(
                      image: _image == null
                          ? getImage()
                          : FileImage(File(_image.path)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      fit: BoxFit.fill,
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
                  items: <String>['Elektrik', 'Su', 'Doğalgaz', 'İnternet']
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
                  onPressed: () => makbuzKaydet(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void makbuzKaydet() async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    if (_image != null) {
      if (dropdownValue == 'Elektrik') {
        var sonuc = await _userModel.savetheelectricalreceipt(
            widget.currentUser, _image);
        print(dropdownValue);
        if (sonuc == true) {
          PlatformDuyarliAlertDialog(
            baslik: 'Başarılı',
            icerik: 'Makbuz kaydedildi...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        } else {
          PlatformDuyarliAlertDialog(
            baslik: 'HATA',
            icerik: 'Sunucuyla ilgili hata oluştu lütfen tekrar deneyiniz...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        }
      } else if (dropdownValue == 'Su') {
        var sonuc = await _userModel.savethewater(widget.currentUser, _image);
        print(dropdownValue);
        if (sonuc == true) {
          PlatformDuyarliAlertDialog(
            baslik: 'Başarılı',
            icerik: 'Makbuz kaydedildi...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        } else {
          PlatformDuyarliAlertDialog(
            baslik: 'HATA',
            icerik: 'Sunucuyla ilgili hata oluştu lütfen tekrar deneyiniz...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        }
      } else if (dropdownValue == 'Doğalgaz') {
        var sonuc =
            await _userModel.savethenaturelgas(widget.currentUser, _image);
        print(dropdownValue);
        if (sonuc == true) {
          PlatformDuyarliAlertDialog(
            baslik: 'Başarılı',
            icerik: 'Makbuz kaydedildi...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        } else {
          PlatformDuyarliAlertDialog(
            baslik: 'HATA',
            icerik: 'Sunucuyla ilgili hata oluştu lütfen tekrar deneyiniz...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        }
      } else if (dropdownValue == 'İnternet') {
        var sonuc =
            await _userModel.savetheinternet(widget.currentUser, _image);
        print(dropdownValue);
        if (sonuc == true) {
          PlatformDuyarliAlertDialog(
            baslik: 'Başarılı',
            icerik: 'Makbuz kaydedildi...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        } else {
          PlatformDuyarliAlertDialog(
            baslik: 'HATA',
            icerik: 'Sunucuyla ilgili hata oluştu lütfen tekrar deneyiniz...',
            anaButonYazisi: 'Tamam',
          ).goster(context);
        }
      }
    }
  }
}
