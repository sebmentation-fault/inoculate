import 'package:firebase_auth/firebase_auth.dart';
import 'package:inoculate/utils/helpers/get_user_token.dart';

/// Core utility to get the authorization header to securely call the backend
Future<Map<String, String>> getAuthorizationHeader(User user) async {
  String userToken = await getUserToken(user);

  // Attach the user token to the HTTP header
  return {
    'Authorization': 'Token $userToken',
    "Content-Type": "application/json",
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
    'Access-Control-Allow-Headers':
        'Origin, X-Requested-With, Content-Type, Accept',
  };
}
