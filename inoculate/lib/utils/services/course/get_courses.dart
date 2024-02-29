import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:inoculate/constants/api_constants.dart';
import 'package:inoculate/utils/helpers/get_auth_header.dart';
import 'package:inoculate/utils/models/course.dart';

/// Gets all the `Course`s.
///
/// Parameters:
/// * the firebase user object
///
/// Returns: a list of courses
Future<List<CourseDetail>> getCourses(User user) async {
  Map<String, String> headers = await getAuthorizationHeader(user);
  Uri endpoint = Uri.parse(getCoursesApi);

  Response response = await get(
    endpoint,
    headers: headers,
  );

  switch (response.statusCode) {
    case 200:
      List<dynamic> body = json.decode(response.body);
      List<CourseDetail> list = [];

      for (Map<String, dynamic> tactic in body) {
        list.add(
            CourseDetail(tactic['id'], tactic['name'], tactic['description']));
      }

      list = body
          .map((tactic) =>
              CourseDetail(tactic['id'], tactic['name'], tactic['description']))
          .toList();

      return list;
    default:
      return [];
  }
}
