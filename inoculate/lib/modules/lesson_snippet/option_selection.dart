import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/constants/markdown_styles.dart';
import 'package:inoculate/core/states/lesson_state.dart';
import 'package:provider/provider.dart';

/// Provides the screen in which a user selects an option.
///
/// If no options are provided, then the default is used: ["Probably Accurate",
/// "Probably Fake", "Not Sure"].
///
/// The answer is the index of the `options`. It is the only required option.
///
/// By default, the "Not Sure" option will always be shown
class OptionSelection extends StatefulWidget {
  final int id;
  final String? information;
  final List<String>? options;
  final int answerIndex;
  final bool? showNotSure;
  final String feedback;

  const OptionSelection(
      {super.key,
      required this.id,
      this.information,
      this.options,
      required this.answerIndex,
      this.showNotSure,
      required this.feedback});

  @override
  State<OptionSelection> createState() => _OptionSelectionState();
}

class _OptionSelectionState extends State<OptionSelection>
    with SingleTickerProviderStateMixin {
  final double _minScreenSize = navigationRailScreenWidth;
  late bool isCardFlipped = false;

  late String information;
  late int answerIndex;
  late bool showNotSure;
  late List<Widget> options = [];
  late String feedbackTitle;
  late String feedbackBody;

  late LessonState _lessonState;

  @override
  void initState() {
    super.initState();

    _lessonState = Provider.of<LessonState>(context, listen: false);

    information = widget.information ?? defualtOptionSelection;
    showNotSure = widget.showNotSure ?? true;
    answerIndex = widget.answerIndex;
    feedbackBody = widget.feedback;

    // build the list of options
    if (widget.options == null) {
      // if there are no options provided, we use accurate/fake
      Widget probablyAccurate = ElevatedButton(
        onPressed: () {
          answerIndex == boolTrue ? _onCorrectSelected(true) : _onIncorrectSelected(false);
        },
        child: const Text(defaultIsAccurate),
      );
      Widget probablyFake = ElevatedButton(
        onPressed: () {
          answerIndex == boolTrue ? _onIncorrectSelected(true) : _onCorrectSelected(false);
        },
        child: const Text(defaultIsFake),
      );

      options.add(probablyAccurate);
      options.add(probablyFake);

      // feedback says what the correct selection was
      feedbackTitle =
          "The correct answer was '${answerIndex == boolTrue ? defaultIsAccurate : defaultIsFake}'";
    } else {
      // options are provided, lets show them as buttons containing Markdown
      List<String> stringOptions = widget.options ?? [];
      stringOptions.asMap().forEach((int index, String data) {
        if (index == answerIndex) {
          Widget option = ElevatedButton(
            onPressed: () => _onCorrectSelected(null),
            child: Text(data),
          );
          options.add(option);
        } else {
          Widget option = ElevatedButton(
            onPressed: () => _onIncorrectSelected(null),
            child: Text(data),
          );
          options.add(option);
        }
      });

      feedbackTitle =
          "It would have been more optimal to select '${stringOptions[answerIndex]}'";
    }

    // Add a "Not Sure" button if needed
    if (showNotSure) {
      Widget notSure = FilledButton(
          onPressed: () => _onIncorrectSelected(null), child: const Text("Not Sure"),);
      options.add(notSure);
    }
  }

  void _onCorrectSelected(bool? isAccurate) {
    _lessonState.onCorrectSelection(widget, isAccurate);
    _lessonState.onNext();
  }

  void _onIncorrectSelected(bool? isAccurate) {
    _lessonState.onIncorrectSelection(widget, isAccurate);

    setState(() {
      isCardFlipped = true;
    });
  }

  void _onNext() {
    _lessonState.onNext();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;

    double height = MediaQuery.of(context).size.height - (hasNavBar ? 100 : 60);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
              maxWidth: width - (32.0 + (hasNavBar ? 0 : 80)),
              maxHeight: height),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: isCardFlipped ? feedbackBody : information,
                  styleSheet: getMarkdownStyle(),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: isCardFlipped
              ? [
                  ElevatedButton(onPressed: _onNext, child: const Text("Next")),
                ]
              : options,
        ),
      ],
    );
  }
}
