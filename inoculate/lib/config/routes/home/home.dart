import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/modules/home_navigation/navigation_bar.dart';
import 'package:inoculate/modules/home_navigation/navigation_rail.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          MediaQuery.of(context).size.width < navigationRailScreenWidth
              ? buildBottomNavigationBar(context)
              : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= navigationRailScreenWidth)
            buildNavigationRail(context),
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
