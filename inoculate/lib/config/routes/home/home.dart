import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/utils/services/auth.dart';
import 'package:provider/provider.dart';

/// The `Home` Widget includes any useful content that should be included in the
/// any of the children of logged-in session pages.
///
/// This means that if the user loads a page for courses, for example, the
/// content in this widget will also be shown.
///
/// In the current version, the `Home` widget includes a media query that
/// displays a Bottom Navigation Bar on small screens (< `x`px) and a
/// Navigation Rail on larger screens (> `x`px).
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  final int _minScreenSize = 640;

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    String greeting = "No UID";

    if (user != null) {
      greeting = user.uid;
    }

    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < _minScreenSize
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), label: 'Courses'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_accounts), label: 'Profile'),
              ],
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
            )
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= _minScreenSize)
            NavigationRail(
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.library_books), label: Text('Courses')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
                NavigationRailDestination(
                    icon: Icon(Icons.manage_accounts), label: Text('Profile')),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              indicatorColor: Theme.of(context).colorScheme.primary,
            ),
          Column(
            children: [
              Text("Your UID: $greeting"),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await _authService.signOut();
                    } on AuthenticationException catch (e) {
                      // TODO: show error dialog
                    }
                  },
                  child: const Text("Sign Out")),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
