import 'dart:async';
import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/error.dart';
import 'package:faturasakla/ui/widget/platform_duyarli_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

enum FormType { Register, LogIn }

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  String _butonText, _linkText, _appbarText;
  var _formType = FormType.Register;

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LogIn ? "Giriş yap" : "Kayıt ol";
    _linkText = _formType == FormType.LogIn
        ? "Bir hesabınız yok mu? Kayıt olun."
        : "Bir hesabınız var mı? Giriş yapın.";
    _appbarText = _formType == FormType.LogIn ? "Giriş yap" : "Kayıt ol";

    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_appbarText),
      ),
      body: _userModel.state == ViewState.Idle
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    alignment: FractionalOffset.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.emailErrorMessage != null
                                ? _userModel.emailErrorMessage
                                : null,
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String savedEmail) {
                            _email = savedEmail;
                          },
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.passwordErrorMessage != null
                                ? _userModel.passwordErrorMessage
                                : null,
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: 'Şifre',
                            labelText: 'Şifre',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String savedPassword) {
                            _password = savedPassword;
                          },
                        ),
                        SizedBox(height: 8),
                        SignInButtonBuilder(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          icon: Icons.email,
                          text: _butonText,
                          backgroundColor: Colors.blue,
                          onPressed: () => _formSubmit(context),
                        ),
                        SizedBox(height: 8),
                        FlatButton(
                          child: Text(_linkText),
                          onPressed: () => _change(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _formSubmit(BuildContext context) async {
    _formKey.currentState.save();
    print("email {$_email} , pass {$_password} ");
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formType == FormType.LogIn) {
      try {
        User _signInUser =
            await _userModel.signInWithEmailAndPasswords(_email, _password);
        if (_signInUser != null) {
          print("SignIn User ${_signInUser.uid.toString()}");
        }
      } on PlatformException catch (e) {
        print('widget login hata yakalandı ' + e.code.toString());
        PlatformDuyarliAlertDialog(
          baslik: 'Oturum Açmada Hata oluştu!!',
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    } else {
      try {
        User _signUpUser =
            await _userModel.createUserWithEmailAndPasswords(_email, _password);
        if (_signUpUser != null) {
          print("SignIn User ${_signUpUser.uid.toString()}");
        }
      } on PlatformException catch (e) {
        PlatformDuyarliAlertDialog(
          baslik: 'Kullanıcı Oluşturmada Hata oluştu!!',
          icerik: Hatalar.goster(e.code),
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }

  void _change() {
    setState(() {
      _formType =
          _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    });
  }
}
