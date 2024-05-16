import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:inoculate/config/wrappers/auth/auth.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/error/popup.dart';
import 'package:inoculate/core/states/route_state.dart';
import 'package:inoculate/utils/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();

    return MultiProvider(
      providers: [
        // Stream that manages the user value
        StreamProvider<User?>.value(value: auth.user, initialData: null),

        // Manage changes to display routes on the navigation rails
        ChangeNotifierProvider(create: ((context) => RouteState())),

        // Manage the alert dialogues
        ChangeNotifierProvider(create: ((_) => AlertDialogueManager())),
        StreamProvider<AlertDialogueDetail?>.value(
          value: alertStreamController.stream,
          initialData: null,
        ),

      ],
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
