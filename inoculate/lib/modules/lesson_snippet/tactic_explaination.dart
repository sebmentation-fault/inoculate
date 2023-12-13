import 'package:flutter/material.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';

/// Class that holds information that explains to the user how the diinformation
/// tactic is used.
class TacticExplaination extends StatefulWidget {
  final String? tacticExplaination;

  const TacticExplaination({super.key, this.tacticExplaination});

  @override
  State<TacticExplaination> createState() => _TacticExplainationState();
}

class _TacticExplainationState extends State<TacticExplaination> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationCard(
          data: widget.tacticExplaination,
        ),
        const Row(children: [
          ElevatedButton(onPressed: null, child: Text("Next")),
        ])
      ],
    );
  }
}
