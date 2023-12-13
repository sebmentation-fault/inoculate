import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/error/route_not_found.dart';
import 'package:inoculate/core/states/route_state.dart';
import 'package:inoculate/modules/home_navigation/navigation_bar.dart';
import 'package:inoculate/modules/home_navigation/navigation_rail.dart';
import 'package:inoculate/modules/home_navigation/navigation_routes.dart';
import 'package:provider/provider.dart';

/// The `Home` Widget includes any useful content that should be included in the
/// any of the children of logged-in session pages.
///
/// This means that if the user loads a page for courses, for example, the
/// content in this widget will also be shown.
///
/// In the current version, the `Home` widget includes a media query that
/// displays a `BottomNavigationBar` on small screens (<
/// `app_contants.navigationRailScreenWidth`px) and a `NavigationRail` on larger
/// screens (> `app_contants.navigationRailScreenWidth`px).
///
/// It depends on the `NavigationRoutes` constant to determine which widget to
/// show when the `routeState` is notified of a change.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    RouteState routeState = Provider.of<RouteState>(context, listen: true);

    return Scaffold(
      bottomNavigationBar:
          MediaQuery.of(context).size.width < navigationRailScreenWidth
              ? buildBottomNavigationBar(context)
              : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= navigationRailScreenWidth)
            buildNavigationRail(context),
          navigationRoutes[routeState.selectedIndex].widget ?? routeNotFound(),
        ],
      ),
    );
  }
}
