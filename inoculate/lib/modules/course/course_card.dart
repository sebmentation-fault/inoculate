import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/utils/models/course.dart';
import 'package:provider/provider.dart';

/// Card that displays a course information
class CourseCard extends StatelessWidget {
  final double _minScreenSize = navigationRailScreenWidth;
  final CourseDetail _courseDetail;

  const CourseCard(this._courseDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;

    double height = MediaQuery.of(context).size.height - (hasNavBar ? 100 : 60);

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
          maxWidth: width - (32.0 + (hasNavBar ? 0 : 80)), maxHeight: height),
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: RawMaterialButton(
          onPressed: () {
            CourseState state =
                Provider.of<CourseState>(context, listen: false);

            state.courseDetail = _courseDetail;
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_courseDetail.name),
          ),
        ),
      ),
    );
  }
}
