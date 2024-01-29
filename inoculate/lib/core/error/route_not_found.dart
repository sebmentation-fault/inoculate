import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/core/error/popup.dart';
import 'package:provider/provider.dart';

class RouteNotFound extends StatelessWidget {
  const RouteNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an alert dialogue
    String title = "Route Not Found!";
    String body = """
      The route could not be found.

      Verify the URL you are trying to reach.

      The availiable URLs are found by accessing the `/api/` endpoint.
    """;
    AlertDialogueDetail error = AlertDialogueDetail(
      PopupType.error,
      context,
      title,
      body,
    );

    AlertDialogueManager manager = Provider.of<AlertDialogueManager>(context);
    manager.addAlert(error);

    return const Placeholder(
      child: MarkdownBody(data: """
          # Error!
          
          Could *not* find the route :(
          """),
    );
  }
}
