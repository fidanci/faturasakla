import 'package:faturasakla/core/Database/UserModel/user_model.dart';
import 'package:faturasakla/core/Model/makbuz.dart';
import 'package:faturasakla/ui/AddScreen/Screen/add_screen.dart';
import 'package:faturasakla/ui/DetailScreen/detail_secreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DogalGazPage extends StatefulWidget {
  @override
  _DogalGazPageState createState() => _DogalGazPageState();
}

class _DogalGazPageState extends State<DogalGazPage> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    var kullanici = _userModel.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Doğalgaz Makbuzlarım'),
      ),
      body: FutureBuilder<List<Makbuz>>(
        future: _userModel.readthenaturelgas(kullanici.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var tumMakbuzlar = snapshot.data;
            if (tumMakbuzlar.length > 0) {
              return RefreshIndicator(
                onRefresh: _makbuzYenile,
                child: ListView.builder(
                  itemCount: tumMakbuzlar.length,
                  itemBuilder: (context, index) {
                    var makbuz = tumMakbuzlar[index];
                    return GestureDetector(
                      child: Card(
                        elevation: 6.0,
                        child: ListTile(
                          title:
                              Text(makbuz.baslik.toString().substring(0, 16)),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(makbuz.photoURL),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              baslik: makbuz.baslik.toString(),
                              photoURL: makbuz.photoURL,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: _makbuzYenile,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.insert_drive_file,
                            color: Theme.of(context).primaryColor,
                            size: 100,
                          ),
                          Text(
                            'Henüz makbuz kaydedilmedi!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: _floatActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  Widget get _floatActionButton => FloatingActionButton(
        child: Icon(Icons.note_add),
        mini: true,
        elevation: 5,
        onPressed: () {
          UserModel _userModel = Provider.of<UserModel>(context, listen: false);
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(
                userID: _userModel.user,
              ),
            ),
          );
        },
      );

  Future<Null> _makbuzYenile() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
