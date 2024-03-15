import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';
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
  const PerformanceReview({super.key});

  @override
  State<PerformanceReview> createState() => _PerformanceReviewState();
}

class _PerformanceReviewState extends State<PerformanceReview> {
  @override
  Widget build(BuildContext context) {
    // get the value of the LessonState from the Provider
    LessonState lessonState = Provider.of<LessonState>(context, listen: false);

    return FutureBuilder(
      future: pushResults(context, lessonState),
      builder: (BuildContext innerContext, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the Future is in progress, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Center(
                  child: Text(
                      "There was an error saving your results: ${snapshot.error}")),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () => exitLesson(innerContext),
                  child: const Text("Exit Lesson")),
            ],
          );
        } else if (snapshot.hasData && snapshot.data == false) {
          return Column(
            children: [
              const Center(
                  child: Text("There was an error saving your results.")),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () => exitLesson(innerContext),
                  child: const Text("Exit Lesson")),
            ],
          );
        }
        return Column(
          children: [
            InformationCard(
              data:
                  "# Performance Review\n\n${getMessage(lessonState)}\n\nYou had ${lessonState.correctSelections.length} correct selections and ${lessonState.incorrectSelections.length} incorrect selections.",
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => exitLesson(innerContext),
                child: const Text("Exit Lesson")),
          ],
        );
      },
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

  Future<bool> pushResults(
      BuildContext context, LessonState lessonState) async {
    User? user = Provider.of<User?>(context, listen: false);

    if (user == null) {
      return false;
    }

    LessonDetail? lessonDetail = lessonState.lessonDetail;

    if (lessonDetail == null) {
      return false;
    }

    try {
      await pushLessonResults(
          user,
          lessonDetail.lessonId,
          lessonDetail.tacticId,
          lessonState.correctSelections,
          lessonState.incorrectSelections);
    } on Exception {
      return false;
    }

    return true;
  }

  void exitLesson(BuildContext context) {
    CourseState courseState = Provider.of<CourseState>(context, listen: false);

    courseState.courseDetail = null;
  }
}
