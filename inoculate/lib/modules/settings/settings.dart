import 'package:flutter/material.dart';

import 'package:inoculate/utils/services/auth.dart';

/// Class that shows some settings for the user.
/// 
/// Includes:
/// 
/// * a sign out button
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ 
        const SizedBox(width: 24,),
        Form(
          child: ElevatedButton(
            onPressed: () async {
              try {
                await AuthService()
                  .signOut();
              } catch (_) {
                // TODO: show dialogue
              }
            }, 
            child: const Text("Sign Out"),
          ),
        ),
      ], 
    );
  }
}