import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:inoculate/config/wrappers/auth/auth.dart';
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

    // Wrapped such that we can make use of the user globally.
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(value: auth.user, initialData: null)
      ],
      child: MaterialApp(
        title: 'Inoculate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}
