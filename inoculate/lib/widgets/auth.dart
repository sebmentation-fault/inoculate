import 'package:flutter/material.dart';

/// Handles a user's session
///
/// If the user is logged in, or the session can be restarted (i.e. opened
/// client shortly after closing it), then the user's home page is the community
/// dashboard, otherwise, it is the log in/register page.
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication Page')),
      body: const SafeArea(child: Column(children: [TextField()])),
    );
  }
}
