import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import 'package:inoculate/constants/api_constants.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';
import 'package:inoculate/utils/helpers/get_auth_header.dart';

/// Posts the results of a lesson to the backend.
///
/// Parameters:
/// * the firebase user object
/// * the disinformation tactic ID
/// * the correct selections
/// * the incorrect selections
Future<void> pushLessonResults(
    User user,
    int lessonId,
    int disinformationTacticId,
    List<OptionSelection> correctSelections,
    List<OptionSelection> incorrectSelections) async {
  Map<String, String> headers = await getAuthorizationHeader(user);

  Uri endpoint = Uri.parse(
    getPostLessonResults(
      disinformationTacticId,
      lessonId,
    ),
  );

  Response response = await post(
    endpoint,
    headers: headers,
    body: json.encode({
      "correct_selections": optionSelectionsToIds(correctSelections),
      "incorrect_selections": optionSelectionsToIds(incorrectSelections),
    }),
  );

  // Check status code
  switch (response.statusCode) {
    case 200:
      return;
    default:
      throw Exception('Failed to post lesson results');
  }
}

List<int> optionSelectionsToIds(List<OptionSelection> selections) {
  List<int> ids = [];
  for (OptionSelection selection in selections) {
    ids.add(selection.id);
  }
  return ids;
}
