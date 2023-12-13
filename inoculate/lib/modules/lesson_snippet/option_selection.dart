import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/modules/lesson_snippet/lesson_snippet.dart';

/// Provides the screen in which a user selects an option.
///
/// If no options are provided, then the default is used: ["Probably Accurate",
/// "Probably Fake", "Not Sure"].
///
/// The answer is the index of the `options`. It is the only required option.
///
/// By default, the "Not Sure" option will always be shown
class OptionSelection extends StatefulWidget {
  final String? information;
  final List<String>? options;
  final int answerIndex;
  final bool? showNotSure;

  const OptionSelection(
      {super.key,
      this.information,
      this.options,
      required this.answerIndex,
      this.showNotSure});

  @override
  State<OptionSelection> createState() => _OptionSelectionState();
}

class _OptionSelectionState extends State<OptionSelection> {
  late String information;
  late int answerIndex;
  late bool showNotSure;
  late List<Widget> options = [];

  final String placeholderInformation = """
  # Example Option Selection

  imagine that the following was a headline, or a social media post for that 
  matter.
  """;

  @override
  void initState() {
    super.initState();

    information = widget.information ?? placeholderInformation;
    showNotSure = widget.showNotSure ?? true;
    answerIndex = widget.answerIndex;

    // build the list of options
    if (widget.options == null) {
      // if there are no options provided, we use accurate/fake
      const Widget probablyAccurate =
          ElevatedButton(onPressed: null, child: Text("Probably Accurate"));
      const Widget probablyFake =
          ElevatedButton(onPressed: null, child: Text("Probably Fake"));

      options.add(probablyAccurate);
      options.add(probablyFake);
    } else {
      // options are provided, lets show them as buttons containing Markdown
      List<String> stringOptions = widget.options ?? [];
      for (String data in stringOptions) {
        Widget option =
            ElevatedButton(onPressed: null, child: Markdown(data: data));
        options.add(option);
      }
    }

    // Add a "Not Sure" button if needed
    if (showNotSure) {
      const Widget notSure =
          FilledButton(onPressed: null, child: Text("Not Sure"));
      options.add(notSure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationCard(
          data: widget.information,
        ),
        Row(children: options),
      ],
    );
  }
}
