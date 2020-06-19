import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Elektrik, Su, DogalGaz, Internet }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Elektrik: TabItemData("Elektrik", Icons.flash_on),
    TabItem.Su: TabItemData("Su", Icons.opacity),
    TabItem.DogalGaz: TabItemData("DogalGaz", Icons.whatshot),
    TabItem.Internet: TabItemData("Internet", Icons.wifi),
  };
}
