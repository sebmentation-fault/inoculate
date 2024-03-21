import 'package:flutter/foundation.dart';

String get apiBase {
  // If testing mode then use localhost, otherwise use the backend server
  return (kReleaseMode || !kDebugMode)
      ? "http://209.38.160.225:8000"
      : "http://localhost:8000";
}

String get prebunkApiBase {
  // If testing mode then use HTTP, otherwise,
  // use HTTPS
  return "$apiBase/api";
}

/// Get the Lesson API path for a given disinformation tactic.
///
/// Parameter: ID for the disinformation tactic.
String getLessonApi(int id) {
  return "$prebunkApiBase/lessons/$id";
}

/// Used to push the results of a lesson back to the server.
String getPostLessonResults(int tactic, int lesson) {
  return "$prebunkApiBase/lessons/$tactic/$lesson";
}

/// Get the Courses API path
String get getCoursesApi {
  return "$prebunkApiBase/disinformation_tactics";
}

/// Get the Course API path for a given tactic.
///
/// Parameter: ID for the disinformation tactic.
String getCourseAPI(int id) {
  return "$prebunkApiBase/disinformation_tactics/$id";
}

String get getRecommendedCourseApi {
  return "$prebunkApiBase/disinformation_tactics/recommended";
}