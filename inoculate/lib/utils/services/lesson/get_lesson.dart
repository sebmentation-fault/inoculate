import 'dart:math';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inoculate/constants/api_constants.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/error/popup.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';
import 'package:inoculate/modules/lesson_snippet/tactic_explaination.dart';
import 'package:inoculate/utils/helpers/get_auth_header.dart';
import 'package:inoculate/utils/models/lesson.dart';
import 'dart:convert';

/// Gets a `Lesson`.
///
/// Parameters:
/// * the firebase user object
/// * the disinformation tactic ID
///
/// Returns: a record with the lesson detail and the list of lesson snippets
Future<(LessonDetail, List<Widget>)?> getLesson(
    BuildContext context, User user, int disinformationTacticId) async {
  Map<String, String> headers = await getAuthorizationHeader(user);

  Uri endpoint = Uri.parse(getLessonApi(disinformationTacticId));

  Response response = await get(
    endpoint,
    headers: headers,
  );

  // Check status code
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> body = json.decode(response.body);
      String name = body['tactic_name'];
      String description = body['tactic_description'];
      List lesson = body['lesson'];

      LessonDetail detail = LessonDetail(body['tactic_id'], body['lesson_id'], body['general_difficulty']);

      // ignore: use_build_context_synchronously
      return (detail, buildLesson(context, lesson));
    default:
      return null;
  }
}

// Convert the json to option selection, incorrect selection and tactic
// explainaiton
List<Widget> buildLesson(BuildContext context, List body) {
  List<Widget> list = [];
  for (Map<String, dynamic> listElement in body) {
    switch (listElement['type']) {
      case 'option_selection':
        OptionSelection? optionSelection =
            buildOptionSelection(context, listElement);
        if (optionSelection != null) {
          list.add(optionSelection);
        } else {
          // error in JSON, log this error
        }
        break;
      case 'tactic_explaination':
        TacticExplaination? tacticExplaination =
            buildTacticExplaination(context, listElement);
        if (tacticExplaination != null) {
          list.add(tacticExplaination);
        } else {
          // error in JSON, log this
        }
        break;
      default:
        break;
    }
  }
  return list;
}

/// Sometimes the JSON string has strange characters. This removes it.
String fixString(String input) {
  return input.replaceAll(r'â..', '');
}

OptionSelection? buildOptionSelection(
    BuildContext context, Map<String, dynamic> item) {

  int id = item['id'];
  String information = fixString(item['body']);
  bool showNotSure = item['not_sure'];
  int answerIndex;
  String feedback = fixString(item['feedback']);

  List<String>? options;

  if (item.containsKey('correct') && item.containsKey('incorrect')) {
    int randomNumber = Random.secure().nextInt(100);
    options = [];
    switch (randomNumber) {
      case > 50:
        options.add(item['correct']);
        options.add(item['incorrect']);
        answerIndex = 0;
        break;
      default:
        options.add(item['incorrect']);
        options.add(item['correct']);
        answerIndex = 1;
        break;
    }
  } else if (item.containsKey('is_accurate')) {
    // treat answer index like a boolean
    bool isAccurate = item['is_accurate'];
    answerIndex = isAccurate ? boolTrue : boolFalse;
  } else {
    // TODO: log the error
    AlertDialogueDetail(
        PopupType.error,
        context,
        "There was an error fetching part of your lesson.",
        """Sorry for the inconvenience.""");
    return null;
  }

  return OptionSelection(
    id: id,
    answerIndex: answerIndex,
    information: information,
    showNotSure: showNotSure,
    options: options,
    feedback: feedback,
  );
}

TacticExplaination? buildTacticExplaination(
    BuildContext context, Map<String, dynamic> item) {
  if (item.containsKey('body')) {
    return TacticExplaination(
      tacticExplaination: fixString(item['body']),
    );
  } else {
    // TODO: log the error
    AlertDialogueDetail(
        PopupType.error,
        context,
        "There was an error fetching an explaination for your lesson.",
        """Sorry for the inconvenience.""");
    return null;
  }
}
