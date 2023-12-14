import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/config/routes/auth/auth.dart';
import 'package:inoculate/config/routes/home/home.dart';
import 'package:provider/provider.dart';

/// This Wrapper returns `Home` if the user is logged in,
/// otherwise, it returns `Auth`.
///
/// It depends on the `Provider.of<User?>` to get the state of if the user is
/// currently signed in or out.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return user == null ? const Auth() : const Home();
  }
}
