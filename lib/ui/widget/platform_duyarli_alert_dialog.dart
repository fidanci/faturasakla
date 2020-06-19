import 'dart:io';
import 'package:faturasakla/ui/widget/platform_duyarli_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class PlatformDuyarliAlertDialog extends PlatformDuyarliWidget {
  final String baslik;
  final String icerik;
  final String anaButonYazisi;
  final String iptalButomYazisi;

  PlatformDuyarliAlertDialog({
    @required this.baslik,
    @required this.icerik,
    @required this.anaButonYazisi,
    this.iptalButomYazisi,
  });

  Future<bool> goster(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) => this);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(this.baslik),
      content: Text(this.icerik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(this.baslik),
      content: Text(this.icerik),
      actions: _dialogButonlariniAyarla(context),
    );
  }

  List<Widget> _dialogButonlariniAyarla(BuildContext context) {
    final tumButonlar = <Widget>[];

    if (Platform.isIOS) {
      if (iptalButomYazisi != null) {
        tumButonlar.add(
          CupertinoDialogAction(
            child: Text(this.iptalButomYazisi),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }
      tumButonlar.add(
        CupertinoDialogAction(
          child: Text(this.anaButonYazisi),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (iptalButomYazisi != null) {
        tumButonlar.add(
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(this.iptalButomYazisi),
          ),
        );
      }
      tumButonlar.add(
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(this.anaButonYazisi),
        ),
      );
    }

    return tumButonlar;
  }
}
