import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget routeNotFound() {
  return const Placeholder(
    child: MarkdownBody(data: """
    # Error

    We were unable to display a widget.
    """),
  );
}
