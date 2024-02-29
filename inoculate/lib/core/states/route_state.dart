import 'package:flutter/foundation.dart';

/// Class that captures which route we are on.
///
/// This is used to ensure that the `NavgiationRail` and `NavigationBar` are
/// kept up-to-date.
class RouteState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onNewRouteSelected(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }
}
