import 'package:flutter/material.dart';
import 'package:one_piece_platform/ui/screens/tabs/tab_navigation_item.dart';

class TabPage extends StatefulWidget {
  static const String id = 'tabs';
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  List<Widget> _initializeTabItems() {
    var tabs = <Widget>[];
    for (final tabItem in TabNavigationItem.items) {
      tabs.add(tabItem.page);
    }
    return tabs;
  }

  List<BottomNavigationBarItem> _initializeNavigationBarItems() {
    var items = <BottomNavigationBarItem>[];
    for (final tabItem in TabNavigationItem.items) {
      items.add(
          BottomNavigationBarItem(icon: tabItem.icon, label: tabItem.label));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _initializeTabItems(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: _initializeNavigationBarItems(),
      ),
    );
  }
}
