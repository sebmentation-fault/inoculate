import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/constants/app_constants.dart';
import 'package:inoculate/constants/markdown_styles.dart';

/// Class that encapsulates displaying information.
///
/// It displays content that is provided as a Markdown string.
class InformationCard extends StatefulWidget {
  final String data;

  const InformationCard({super.key, required this.data});

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  final double _minScreenSize = navigationRailScreenWidth;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool hasNavBar = MediaQuery.of(context).size.width < _minScreenSize;

    double height = MediaQuery.of(context).size.height - (hasNavBar ? 100 : 60);
    
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
          maxWidth: width - (32.0 + (hasNavBar ? 0 : 80)), maxHeight: height),
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: MarkdownBody(
              data: widget.data,
              styleSheet: getMarkdownStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
