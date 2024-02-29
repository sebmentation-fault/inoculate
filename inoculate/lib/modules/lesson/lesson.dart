import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/modules/lesson/performance_review.dart';
import 'package:inoculate/utils/services/lesson/get_lesson.dart';
import 'package:provider/provider.dart';

/// Simply put, a `Lesson` is a sequence of `LessonSnippets`, except that the
/// initial screen is a preview, and the final screen is an evaluation page.
///
/// A `Lesson` is designed to be used on a per-disinformation tactic basis.
class Lesson extends StatefulWidget {
  final int disinformationTactic;

  const Lesson(this.disinformationTactic, {super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  late Future<List<Widget>?> _lessonSnippets;
  LessonState? _lessonState;

  @override
  void initState() {
    super.initState();
    _lessonSnippets = _fetchLesson();
  }

  Future<List<Widget>?> _fetchLesson() async {
    User? user = Provider.of<User?>(context, listen: false);

    if (user == null) {
      return null;
    }

    return await getLesson(context, user, widget.disinformationTactic);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (notifierContext) => LessonState()),
      ],
      child: FutureBuilder<List<Widget>?>(
        future: _lessonSnippets,
        builder: (innerContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the Future is in progress, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If we run into an error, display it to the user
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData &&
              (snapshot.data == null || snapshot.data!.isEmpty)) {
            // The API call was successful but the lesson count is 0
            return const Center(
              child:
                  Text('Error: The API call worked, but no data was recieved'),
            );
          } else if (snapshot.hasData) {
            // When the Future completes successfully, display the data
            _lessonState ??=
                Provider.of<LessonState>(innerContext, listen: true);

            // if lessonState.currentIndex > last elem, then display lesson is
            // complete

            List<Widget> snippets = snapshot.data!;

            // Specify the ValueKey
            // default VK is the widget type - which does not update when there
            // is two or more option selection widgets in a row
            return _lessonState!.currentIndex < snippets.length
                ? Center(
                    key: ValueKey(_lessonState!.currentIndex),
                    child: snippets[_lessonState!.currentIndex],
                  )
                : const PerformanceReview();
          } else {
            // Unknown error
            return const Center(
              child: Text('Error: An unexpected error has occurred'),
            );
          }
        },
      ),
    );
  }
}
