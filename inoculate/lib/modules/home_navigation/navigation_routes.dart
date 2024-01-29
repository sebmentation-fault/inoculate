import 'package:flutter/material.dart';
import 'package:inoculate/core/error/route_not_found.dart';
import 'package:inoculate/modules/lesson/lesson.dart';
import 'package:inoculate/widgets/api_routes.dart';

const List<NavigationRoute> navigationRoutes = [
  NavigationRoute(
    "Home",
    Icon(Icons.home),
    routeWidget: ApiRoutes(),
  ),
  NavigationRoute(
    "Courses",
    Icon(Icons.golf_course),
    routeWidget: Lesson(disinformationTactic: 0),
  ),
  NavigationRoute("Settings", Icon(Icons.settings)),
  NavigationRoute("Profile", Icon(Icons.manage_accounts)),
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
