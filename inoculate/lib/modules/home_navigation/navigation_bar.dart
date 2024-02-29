import 'package:flutter/material.dart';
import 'package:inoculate/core/states/route_state.dart';
import 'package:inoculate/modules/home_navigation/navigation_routes.dart';
import 'package:provider/provider.dart';

BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  RouteState routeState = Provider.of<RouteState>(context, listen: true);
  List<BottomNavigationBarItem> destinations = [];

  for (NavigationRoute route in navigationRoutes) {
    destinations
        .add(BottomNavigationBarItem(icon: route.icon, label: route.label));
  }

  return BottomNavigationBar(
    items: destinations,
    currentIndex: routeState.selectedIndex,
    onTap: (value) => routeState.onNewRouteSelected(value),

    // Theming
    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    selectedItemColor: Theme.of(context).colorScheme.primary,
    unselectedItemColor: Theme.of(context).colorScheme.secondary,
  );
}
