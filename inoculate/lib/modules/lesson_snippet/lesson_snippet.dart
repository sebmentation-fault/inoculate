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

  --- 

  # Testing/Debugging:

  The following should all work.

  Lists:

   * item
   * another item
   * one more
  
  Enumerated lists:

   1. item
      
      continuation of item

   2. another item
   3. one more

   Displaying an image:

   ![Local Image](resource://assets/images/royalty-free-fake-news-image.jpg)
  """;
  static const String exExp = "# Error!";

  final String? data;

  const InformationCard({super.key, this.data});

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  final int _minScreenSize = 640;
  late String data;

  @override
  void initState() {
    super.initState();

    data = widget.data ?? InformationCard.defaultExplaination;
  }

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
              data: data,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            ),
          ),
        ),
      ),
    );
  }
}
