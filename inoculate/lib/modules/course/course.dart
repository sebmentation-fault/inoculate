import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/modules/course/course_preview.dart';
import 'package:inoculate/modules/lesson/lesson.dart';
import 'package:inoculate/utils/models/course.dart';
import 'package:provider/provider.dart';

/// A `Course` is one which aims to inoculate users on a specific disinformation
/// tactic.
///x
/// For a course, a user should be able to see the tactic name, a description
/// and history of lessons.
///
/// The user should be able to start a new lesson for a course.
class Course extends StatefulWidget {
  final CourseDetail _courseDetail;
  final bool? showBack;

  const Course(this._courseDetail, {super.key, this.showBack});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  bool showLesson = false;
  late bool showBack;

  @override
  void initState() {
    super.initState();
    showBack = widget.showBack == true;
  }

  @override
  Widget build(BuildContext context) {

    return showLesson == false
        ? Column(
            children: showBack == true ? [
              Container(
                child: widget.showBack == true ? Row(children: [
                  ElevatedButton(
                    onPressed: () {
                      CourseState? courseState =
                        Provider.of<CourseState>(context, listen: false);
                      courseState.courseDetail = null;
                    }, 
                    child: const Text('Back'),
                  ), 
                ],) : null,
              ),
              CoursePreview(widget._courseDetail),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showLesson = true;
                      showBack = false;
                    });
                  },
                  child: const Row(
                    children: [
                      Text("Start Lesson"),
                    ]
                  ),
                )
              ] : [
              CoursePreview(widget._courseDetail),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showBack = false;
                      showLesson = true;
                    });
                  },
                  child: const Row(
                    children: [
                      Text("Start Lesson"),
                    ]
                  ),
                )
              ],
          )
        : Lesson(widget._courseDetail.id);
  }
}
