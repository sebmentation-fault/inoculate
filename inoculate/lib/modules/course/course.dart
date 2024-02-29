import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/modules/lesson/lesson.dart';
import 'package:inoculate/utils/models/course.dart';

/// A `Course` is one which aims to inoculate users on a specific disinformation
/// tactic.
///x
/// For a course, a user should be able to see the tactic name, a description
/// and history of lessons.
///
/// The user should be able to start a new lesson for a course.
class Course extends StatefulWidget {
  final CourseDetail _courseDetail;

  const Course(this._courseDetail, {super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  bool showLesson = false;

  @override
  Widget build(BuildContext context) {
    return showLesson == false
        ? Column(
            children: [
              Text(widget._courseDetail.name),
              MarkdownBody(data: widget._courseDetail.description),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showLesson = true;
                    });
                  },
                  child: const Text("Go to Lesson"))
            ],
          )
        : Lesson(widget._courseDetail.id);
  }
}
