import 'package:firebase_auth/firebase_auth.dart';

/// Core utility to get the user token, given the firebase object, safely
Future<String> getUserToken(User user) async {
  String? userToken = await user.getIdToken();

  if (userToken == null) {
    throw Exception("User token was not fetched");
  }

  return userToken;
}
