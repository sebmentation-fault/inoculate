import 'package:flutter/material.dart';
import 'package:inoculate/core/states/course_state.dart';

import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';
import 'package:inoculate/utils/models/course.dart';
import 'package:provider/provider.dart';

class CoursePreview extends StatelessWidget {
  final CourseDetail _courseDetail;

  const CoursePreview(this._courseDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      InformationCard(
        data: "# Preview\n\n---\n\n## ${_courseDetail.name}\n\n${_courseDetail.description}",
      ),
    ],
  );
  }
}