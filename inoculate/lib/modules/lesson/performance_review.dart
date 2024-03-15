import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/widgets/confusion_matrix.dart';
import 'package:provider/provider.dart';

/// A widget that displays an overall review of the user's performance in the
/// lesson.
///
/// The widget shows a message.
///
/// The widget has a button to return to the course selection screen.
class PerformanceReview extends StatelessWidget {

  final double _minScreenSize = navigationRailScreenWidth;

  const PerformanceReview({super.key});

  @override
  Widget build(BuildContext context) {
    // get the value of the LessonState from the Provider
    LessonState lessonState = Provider.of<LessonState>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;
    double height = MediaQuery.of(context).size.height - (hasNavBar ? 100 : 60);
  

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxWidth: width - (32.0 + (hasNavBar ? 0 : 80)), maxHeight: height),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: MarkdownBody(
                      data: "# Performance Review\n\n${getMessage(lessonState)}\n\nYou had ${lessonState.correctSelections.length} correct selections and ${lessonState.incorrectSelections.length} incorrect selections.",
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
                   ),
                  ),
                  ConfusionMatrix(lessonState.truePositives, lessonState.falsePositives, lessonState.trueNegatives, lessonState.falseNegatives),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () => exitLesson(context),
            child: const Text("Exit Lesson")),
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

  void exitLesson(BuildContext context) {
    CourseState courseState = Provider.of<CourseState>(context, listen: false);

    courseState.courseDetail = null;
  }
}
