import 'package:flutter/material.dart';

const List navigationRoutes = [
  NavigationRoute(label: "Home", icon: Icon(Icons.home)),
  NavigationRoute(label: "Courses", icon: Icon(Icons.golf_course)),
  NavigationRoute(label: "Settings", icon: Icon(Icons.settings)),
  NavigationRoute(label: "Profile", icon: Icon(Icons.manage_accounts)),
];

class NavigationRoute {
  final String label;
  final Icon icon;

  const NavigationRoute({required this.label, required this.icon});
}
