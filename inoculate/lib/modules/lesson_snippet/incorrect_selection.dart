import 'package:flutter/material.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';

class IncorrectSelection extends StatefulWidget {
  final String? incorrectSelectionMessage;
  final String? feedback;

  const IncorrectSelection(
      {super.key, this.incorrectSelectionMessage, this.feedback});

  @override
  State<IncorrectSelection> createState() => _IncorrectSelectionState();
}

class _IncorrectSelectionState extends State<IncorrectSelection> {
  @override
  Widget build(BuildContext context) {
    String message =
        (widget.incorrectSelectionMessage ?? defaultIncorrectSelection) +
            (widget.feedback ?? defualtFeedback);

    return Column(
      children: [
        InformationCard(
          data: message,
        ),
        const Row(children: [
          ElevatedButton(onPressed: null, child: Text("Next")),
        ])
      ],
    );
  }
}
