import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';
import 'package:provider/provider.dart';

/// Class that holds information that explains to the user how the diinformation
/// tactic is used.
class TacticExplaination extends StatefulWidget {
  final String? tacticExplaination;

  const TacticExplaination({super.key, this.tacticExplaination});

  @override
  State<TacticExplaination> createState() => _TacticExplainationState();
}

class _TacticExplainationState extends State<TacticExplaination> {
  late LessonState _lessonState;

  @override
  void initState() {
    super.initState();

    _lessonState = Provider.of<LessonState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    String data = widget.tacticExplaination ?? defaultTacticExplaination;

    return Column(
      children: [
        InformationCard(
          data: data,
        ),
        Row(children: [
          ElevatedButton(onPressed: _onNext, child: const Text("Next")),
        ])
      ],
    );
  }

  void _onNext() {
    _lessonState.onNext();
  }
}
