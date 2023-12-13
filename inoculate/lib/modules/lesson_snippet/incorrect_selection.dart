import 'package:flutter/material.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';

class IncorrectSelection extends StatefulWidget {
  final String? feedback;
  static const String incorrectMessage = "# Incorrect Selection!\n";

  const IncorrectSelection({super.key, this.feedback});

  @override
  State<IncorrectSelection> createState() => _IncorrectSelectionState();
}

class _IncorrectSelectionState extends State<IncorrectSelection> {
  @override
  Widget build(BuildContext context) {
    String message = IncorrectSelection.incorrectMessage +
        (widget.feedback ?? "There was a more optimal selection to have made.");

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
