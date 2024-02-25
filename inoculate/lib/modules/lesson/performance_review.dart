import 'package:flutter/material.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';
import 'package:provider/provider.dart';

/// A widget that displays an overall review of the user's performance in the
/// lesson.
///
/// The widget shows a message.
///
/// The widget has a button to return to the course selection screen.
class PerformanceReview extends StatelessWidget {
  const PerformanceReview({super.key});

  @override
  Widget build(BuildContext context) {
    // get the value of the LessonState from the Provider
    LessonState lessonState = Provider.of<LessonState>(context, listen: false);

    return Column(
      children: [
        InformationCard(
          data:
              "# Performance Review\n\n${getMessage(lessonState)}\n\nYou had ${lessonState.correctSelections.length} correct selections and ${lessonState.incorrectSelections.length} incorrect selections.",
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
