import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:inoculate/constants/api_constants.dart';
import 'package:inoculate/utils/helpers/get_auth_header.dart';
import 'package:inoculate/utils/models/course.dart';

/// Gets the disinformation tactic that has the recommended tactic.
///
/// Parameters:
/// * the firebase user object
///
/// Returns: a recommended course, or null
Future<CourseDetail?> getRecommendedCourse(User user) async {
  Map<String, String> headers = await getAuthorizationHeader(user);
  Uri endpoint = Uri.parse(getRecommendedCourseApi);

  Response response = await get(
    endpoint,
    headers: headers,
  );

  switch (response.statusCode) {
    case 200:
      try {
        Map<String, dynamic> tactic = json.decode(response.body);

        return CourseDetail(tactic['id'], tactic['name'], tactic['description']);
      } catch (_) {
        return null;
      }
    default:
      return null;
  }
}