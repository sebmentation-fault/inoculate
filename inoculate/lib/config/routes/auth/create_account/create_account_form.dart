import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/utils/services/auth.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  String _email = "";
  bool _emailIsValid = false;
  String _password = "";
  String _passwordVerify = "";
  bool _passwordsMatch = false;
  bool _accountIsValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text("Create an account:",
              style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 40),
          const Text("Input your email:"),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (String e) {
              // TODO: check if email has suitable format
              setState(() {
                _email = e;
                _emailIsValid = e.contains('@') && e.contains('.');
                _accountIsValid = _emailIsValid && _passwordsMatch;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text("Input a secure password:"),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onChanged: (String p) {
              setState(() {
                _password = p;
                _passwordsMatch = (p.compareTo(_passwordVerify) == 0);
                _accountIsValid = _emailIsValid && _passwordsMatch;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text("Input your password again:"),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onChanged: (String p) {
              setState(() {
                _passwordVerify = p;
                _passwordsMatch = (p.compareTo(_password) == 0);
                _accountIsValid = _emailIsValid && _passwordsMatch;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _accountIsValid
                ? () async {
                    User? user;
                    try {
                      user = await AuthService()
                          .createUserWithEmailAndPassword(_email, _password);
                    } on AuthenticationException {
                      // TODO: show error dialog
                    }
                  }
                : null,
            child: const Text("Create Account"),
          )
        ],
      ),
    );
  }
}
