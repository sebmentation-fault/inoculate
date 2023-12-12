import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Class that encapsulates displaying information.
///
/// It displays content that is provided as a Markdown string.
class InformationCard extends StatefulWidget {
  static const String defaultExplaination = """
  # Error on our side!

  Sorry, we were not able to fetch the explaination for this `Lesson`. We will
  attempt to fix this as soon as possible.

  ---

  #### Note:

  It could be worth checking your internet connectivity/firewall settings, as 
  these could prevent `Inoculate` from loading the messages from our server.
  """;
  static const String exExp = "# Error!";

  const InformationCard({super.key});

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  final int _minScreenSize = 640;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          constraints:
              BoxConstraints(maxWidth: width - (32.0 + (hasNavBar ? 0 : 80))),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: InformationCard.defaultExplaination,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
