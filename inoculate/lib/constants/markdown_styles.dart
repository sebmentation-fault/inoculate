import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownStyleSheet getMarkdownStyle() {
  return MarkdownStyleSheet(
    h1: const TextStyle(fontSize: 36),
    h2: const TextStyle(fontSize: 32),
    h3: const TextStyle(fontSize: 28),

    p: const TextStyle(fontSize: 24),
  );
}