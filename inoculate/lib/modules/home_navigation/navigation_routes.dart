import 'package:flutter/material.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';
import 'package:inoculate/widgets/api_routes.dart';

const List<NavigationRoute> navigationRoutes = [
  NavigationRoute(
    label: "Home",
    icon: Icon(Icons.home),
    widget: ApiRoutes(),
  ),
  NavigationRoute(
    label: "Courses",
    icon: Icon(Icons.golf_course),
    widget: OptionSelection(
      answerIndex: 0,
    ),
  ),
  NavigationRoute(label: "Settings", icon: Icon(Icons.settings)),
  NavigationRoute(label: "Profile", icon: Icon(Icons.manage_accounts)),
];

class NavigationRoute {
  final String label;
  final Icon icon;
  final Widget? widget;

  const NavigationRoute({required this.label, required this.icon, this.widget});
}
