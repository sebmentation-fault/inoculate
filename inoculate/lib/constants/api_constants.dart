import 'package:flutter/foundation.dart';

String get apiBase {
  // If testing mode then use HTTP, otherwise,
  // use HTTPS
  return kReleaseMode ? "https://localhost:8000/" : "http://localhost:8000/";
}

String get prebunkApiBase {
  // If testing mode then use HTTP, otherwise,
  // use HTTPS
  return kReleaseMode
      ? "https://localhost:8000/api/"
      : "http://localhost:8000/api/";
}
