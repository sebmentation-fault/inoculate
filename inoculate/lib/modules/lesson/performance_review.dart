import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/widgets/confusion_matrix.dart';
import 'package:inoculate/utils/models/lesson.dart';
import 'package:inoculate/utils/services/lesson/post_lesson_results.dart';

import 'package:provider/provider.dart';

/// A widget that displays an overall review of the user's performance in the
/// lesson.
///
/// The widget shows a message.
///
/// The widget has a button to return to the course selection screen.
class PerformanceReview extends StatefulWidget {
  final double _minScreenSize = navigationRailScreenWidth;

  const PerformanceReview({super.key});

  @override
  State<PerformanceReview> createState() => _PerformanceReviewState();
}

class _PerformanceReviewState extends State<PerformanceReview> {
  final double _minScreenSize = navigationRailScreenWidth;
  String _message = "Unkown.";

  @override
  Widget build(BuildContext context) {
    // get the value of the LessonState from the Provider
    LessonState lessonState = Provider.of<LessonState>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;
    double height = MediaQuery.of(context).size.height - (hasNavBar ? 100 : 60);

    return Column(
      children: [
        const SizedBox(height: 48,),
        Expanded(
          child: SingleChildScrollView(
            child: MarkdownBody(
              data: "# Performance Review\n\n${getMessage(lessonState)}\n\nYou had ${lessonState.correctSelections.length} correct selections and ${lessonState.incorrectSelections.length} incorrect selections.",
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            ),
          ),
        ),
        ConfusionMatrix(
            lessonState.truePositives,
            lessonState.falsePositives,
            lessonState.trueNegatives,
            lessonState.falseNegatives),
        const SizedBox(height: 24,),
        FutureBuilder<bool>(
          future: pushResults(context),
          builder: (innerContext, snapshot) {
            bool isLoading = snapshot.connectionState == ConnectionState.waiting;
            Widget errorWidget = Container();
            if (isLoading) {
              errorWidget = const Row(children: [CircularProgressIndicator(), Text('Saving results...')],);
            } else if (snapshot.hasError || (snapshot.hasData && !snapshot.data!)) {
              errorWidget = Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red),
                  Text('Error saving results. Reason: $_message'),
                ],
              );
            } 
            return Column(
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : () => exitLesson(innerContext),
                  child: const Text("Exit Lesson"),
                ),
                const SizedBox(height: 24,),
                errorWidget,
                const SizedBox(height: 24,),
              ],
            );
          },
        ),
      ],
    );
  }

  String getMessage(LessonState lessonState) {
    if (lessonState.correctSelections.length >
        lessonState.incorrectSelections.length) {
      return "Great job! You're doing well!";
    } else if (lessonState.correctSelections.length ==
        lessonState.incorrectSelections.length) {
      return "You're doing okay. Keep it up!";
    } else {
      return "You're struggling a bit. Keep practicing!";
    }
  }

  Future<bool> pushResults(BuildContext context) async {
    User? user = Provider.of<User?>(context, listen: false);
    LessonState lessonState = Provider.of<LessonState>(context, listen: false);

    if (user == null) {
      _message = "Invalid user";
      return false;
    }

    LessonDetail? lessonDetail = lessonState.lessonDetail;

    if (lessonDetail == null) {
      _message = "Lesson is null";
      return false;
    }

    int result;

    try {
      result = await pushLessonResults(
          user,
          lessonDetail.lessonId,
          lessonDetail.tacticId,
          lessonState.correctSelections,
          lessonState.incorrectSelections);
    } catch (_) {
      _message = "Exception encountered";
      return false;
    }

    switch (result) {
      case 401:
        _message = "Unauthorised - cannot save result";
        break;
    }

    _message = "Success";
    return true;
  }

  void exitLesson(BuildContext context) {
    CourseState courseState = Provider.of<CourseState>(context, listen: false);

    courseState.courseDetail = null;
  }
}
