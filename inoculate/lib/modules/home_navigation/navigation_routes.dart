import 'package:flutter/material.dart';
import 'package:inoculate/core/error/route_not_found.dart';
import 'package:inoculate/modules/course/courses.dart';
import 'package:inoculate/modules/recommended/recommended.dart';
import 'package:inoculate/modules/settings/settings.dart';

const List<NavigationRoute> navigationRoutes = [
  NavigationRoute(
    "Home",
    Icon(Icons.home),
    routeWidget: RecommendedCourse(),
  ),
  NavigationRoute(
    "Courses",
    Icon(Icons.golf_course),
    routeWidget: Courses(),
  ),
  NavigationRoute("Settings", Icon(Icons.settings), routeWidget: Settings()),
];

class NavigationRoute {
  final String label;
  final Icon icon;
  final Widget? routeWidget;

  const NavigationRoute(this.label, this.icon, {this.routeWidget});

  Widget get widget {
    return routeWidget ?? const RouteNotFound();
  }
}
