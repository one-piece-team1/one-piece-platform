import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_piece_platform/ui/screens/dashboard.dart';
import 'package:one_piece_platform/ui/screens/trip/add_trip.dart';
import 'package:one_piece_platform/ui/screens/user/user_info.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.label,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: DashBoard(),
          label: "Trip",
          icon: Icon(Icons.home),
        ),
        TabNavigationItem(
          page: AddTrip(),
          label: 'Add',
          icon: Icon(Icons.add_circle_outline),
        ),
        TabNavigationItem(
          page: UserInfo(),
          label: "Member",
          icon: Icon(Icons.account_circle),
        )
      ];
}
