import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inoculate/core/states/course_state.dart';
import 'package:inoculate/modules/course/course.dart';
import 'package:inoculate/modules/course/course_card.dart';
import 'package:inoculate/utils/models/course.dart';
import 'package:inoculate/utils/services/course/get_courses.dart';
import 'package:provider/provider.dart';

/// Displays a list of all the avilaible courses
class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late Future<List<CourseDetail>> _courses;
  CourseState? _courseState;

  @override
  void initState() {
    super.initState();
    _courses = _fetchCourses();
  }

  Future<List<CourseDetail>> _fetchCourses() async {
    User? user = Provider.of<User?>(context, listen: false);

    if (user == null) {
      return [];
    }

    return await getCourses(user);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (notifierContext) => CourseState())
      ],
      child: FutureBuilder(
          future: _courses,
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
                child: Text(
                    'Error: The API call worked, but no data was recieved'),
              );
            } else if (snapshot.hasData) {
              // When the Future completes successfully, display the data
              _courseState ??=
                  Provider.of<CourseState>(innerContext, listen: true);

              List<CourseDetail> details = snapshot.data!;

              return (_courseState!.courseDetail == null)
                  ? Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 800,
                          minHeight: 400,
                          minWidth: 350,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: details.length,
                          itemBuilder: (listContext, index) {
                            // return a card that has the course information
                            return CourseCard(details[index]);
                          },
                        ),
                      ),
                    )
                  : Course(_courseState!.courseDetail!);
            } else {
              // Unknown error
              return const Center(
                child: Text('Error: An unexpected error has occurred'),
              );
            }
          }),
    );
  }
}
