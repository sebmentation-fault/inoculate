import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/utils/services/auth.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String _email = "";
  String _password = "";
  bool _logInDetailsValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text("Sign In:", style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 40),
          const Text("Input your email:"),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (String e) {
              // TODO: check if email has suitable format
              setState(() {
                _email = e;
                _logInDetailsValid =
                    _email.contains('@') && _password.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text("Input your password:"),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onChanged: (String p) {
              setState(() {
                _password = p;
                _logInDetailsValid =
                    _email.contains('@') && _password.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  User? user;
                  try {
                    user = await AuthService().signInAnonomous();
                  } on AuthenticationException catch (e) {
                    // TODO: show error dialog
                  }
                },
                child: const Text("Sign In Anonomously"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _logInDetailsValid
                    ? () async {
                        User? user;
                        try {
                          user = await AuthService()
                              .signInWithEmailAndPassword(_email, _password);
                        } on AuthenticationException catch (e) {
                          // TODO: show error dialog
                        }
                      }
                    : null,
                child: const Text("Sign In"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
