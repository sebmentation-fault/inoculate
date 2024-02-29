import 'package:flutter/material.dart';
import 'package:inoculate/utils/models/course.dart';

/// Class that captures which course we are on.
///
/// This is used to ensure that the `Course` view is kept up-to-date.
///
/// If `courseDetail` is null, then no course is selected - show the list of
/// courses.
/// Otherwise, show the course information/start a lesson.
class CourseState extends ChangeNotifier {
  CourseDetail? _courseDetail;

  set courseDetail(CourseDetail? courseDetail) {
    _courseDetail = courseDetail;
    notifyListeners();
  }

  CourseDetail? get courseDetail {
    return _courseDetail;
  }
}
