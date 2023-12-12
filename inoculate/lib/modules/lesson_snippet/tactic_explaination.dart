import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';

/// Class that holds information that explains to the user how the diinformation
/// tactic is used.
class TacticExplaination extends StatelessWidget {
  late String? tacticExplaination;

  TacticExplaination({super.key, this.tacticExplaination});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InformationCard(),
        Row(children: [
          ElevatedButton(onPressed: null, child: Text("Next")),
        ])
      ],
    );
  }
}
