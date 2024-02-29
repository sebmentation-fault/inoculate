import 'package:flutter/material.dart';
import 'package:inoculate/core/states/route_state.dart';
import 'package:inoculate/modules/home_navigation/navigation_routes.dart';
import 'package:provider/provider.dart';

NavigationRail buildNavigationRail(BuildContext context) {
  RouteState routeState = Provider.of<RouteState>(context, listen: true);
  List<NavigationRailDestination> destinations = [];

  for (NavigationRoute route in navigationRoutes) {
    destinations.add(
        NavigationRailDestination(icon: route.icon, label: Text(route.label)));
  }

  return NavigationRail(
    destinations: destinations,
    selectedIndex: routeState.selectedIndex,
    onDestinationSelected: (value) => routeState.onNewRouteSelected(value),

    // Theming
    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    indicatorColor: Theme.of(context).colorScheme.primaryContainer,
  );
}
