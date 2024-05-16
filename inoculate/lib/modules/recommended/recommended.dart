import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/modules/course/course.dart';
import 'package:inoculate/utils/models/course.dart';
import 'package:inoculate/utils/services/course/get_recommended_course.dart';
import 'package:provider/provider.dart';

/// Displays the recommended course/tactic to begin a lesson for
class RecommendedCourse extends StatefulWidget {
  const RecommendedCourse({super.key});

  @override
  State<RecommendedCourse> createState() => _RecommendedCourseState();
}

class _RecommendedCourseState extends State<RecommendedCourse> {
  late Future<CourseDetail?> _courseDetail;
  CourseState? _courseState;

  @override
  void initState() {
    super.initState();
    _courseDetail = _fetchRecommended();
  }

  Future<CourseDetail?> _fetchRecommended() async {
    User? user = Provider.of<User?>(context, listen: false);

    if (user == null) {
      return null;
    }

    return await getRecommendedCourse(user);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (notifierContext) => CourseState())
      ],
      child: FutureBuilder(
          future: _courseDetail,
          builder: (innerContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the Future is in progress, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If we run into an error, display it to the user
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData &&
                (snapshot.data == null)) {
              // The API call was successful but the course detail is null
              return const Center(
                child: Text(
                    'Error: API call did not work'),
              );
            } else if (snapshot.hasData) {
              // When the Future completes successfully, display the data
              _courseState ??=
                  Provider.of<CourseState>(innerContext, listen: true);

              CourseDetail detail = snapshot.data!;

              return (_courseState!.courseDetail == null)
                ? Column(
                    children: [
                      const SizedBox(height: 24,),
                      Course(detail),
                    ],)
                : ElevatedButton(
                  onPressed: getNewLesson, 
                  child: const Text("Try again"),
              );
            } else {
              // Unknown error
              return const Center(
                child: Text('Error: An unexpected error has occurred'),
              );
            }
          }),
    );
  }

  void getNewLesson() async {
    setState(() {
      _courseDetail = _fetchRecommended();
    });
  }
}
