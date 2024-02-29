import "package:flutter/material.dart";
import "package:inoculate/config/routes/auth/create_account/create_account_form.dart";
import "package:inoculate/config/routes/auth/sign_in/sign_in_form.dart";

/// The `Auth` is a master widget that displays the children `SignIn` or
/// `CreateAccount`. This widget displays only one at a time, and has a slider
/// to navigate between each one.
class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _showSignIn = true; // flag for either sign in or create account widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: _showSignIn
                          ? const SignInForm()
                          : const CreateAccountForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showSignIn = !_showSignIn;
                  });
                },
                child: _showSignIn
                    ? const Text("Don't have an account yet? Create one")
                    : const Text("Already have an account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
