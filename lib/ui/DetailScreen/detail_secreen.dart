import 'package:faturasakla/ui/FotografGoruntule/fotograf_goruntule_network.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String baslik;
  final String photoURL;

  const DetailScreen({Key key, @required this.baslik, @required this.photoURL})
      : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var _baslik = widget.baslik;
    var _photoURL = widget.photoURL;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return;
            },
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(_baslik.substring(0, 16)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: NetworkImage(_photoURL),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: ListTile(
                  title: Text('Fotoğrafı Görüntüle'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FotografGoruntuleNetwork(photoURL: _photoURL),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
