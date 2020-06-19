import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/ui/home/screen/BotomNavigationBar/my_bottom_navi.dart';
import 'package:faturasakla/ui/home/screen/BotomNavigationBar/tab_items.dart';
import 'package:faturasakla/ui/home/screen/body/dogalgaz.dart';
import 'package:faturasakla/ui/home/screen/body/elektrik.dart';
import 'package:faturasakla/ui/home/screen/body/internet.dart';
import 'package:faturasakla/ui/home/screen/body/su.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Elektrik;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Elektrik: GlobalKey<NavigatorState>(),
    TabItem.Su: GlobalKey<NavigatorState>(),
    TabItem.DogalGaz: GlobalKey<NavigatorState>(),
    TabItem.Internet: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Elektrik: ElektrikPage(),
      TabItem.Su: SuPage(),
      TabItem.DogalGaz: DogalGazPage(),
      TabItem.Internet: InternetPage(),
      
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MyCustomBottomNavigation(
        currentTab: _currentTab,
        sayfaOlusturucu: tumSayfalar(),
        navigatorKeys: navigatorKeys,
        onSelectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
        },
      ),
    );
  }
}
