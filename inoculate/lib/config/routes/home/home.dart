import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/modules/lesson_snippet/incorrect_selection.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';
import 'package:inoculate/modules/lesson_snippet/tactic_explaination.dart';
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
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width <
              navigationRailScreenWidth
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
          if (MediaQuery.of(context).size.width >= navigationRailScreenWidth)
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
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          //const OptionSelection(
          //  answerIndex: 0,
          //),
          //TacticExplaination(
          //  tacticExplaination: "# Hello",
          //),
          const IncorrectSelection(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
