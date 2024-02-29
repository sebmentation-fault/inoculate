import "package:firebase_auth/firebase_auth.dart";
import 'package:http/http.dart';
import 'package:inoculate/constants/api_constants.dart';
import 'package:inoculate/utils/helpers/get_auth_header.dart';
import 'dart:convert';

/// Get the API routes.
///
/// If the API routes do not have a status code of OK, then return a string
/// containting an error message.
Future<String> getApiRoutes(User user) async {
  Map<String, String> headers = await getAuthorizationHeader(user);

  String apiRoute = prebunkApiBase;

  Response response = await get(
    Uri.parse(apiRoute),
    headers: headers,
  );

  // Check status code
  switch (response.statusCode) {
    case 200:
      List<dynamic> body = json.decode(response.body);

      return body.toString();
    default:
      return "Error handling the response. Unkown status code.";
  }
}
