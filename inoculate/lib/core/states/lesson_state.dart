import 'package:flutter/foundation.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';

/// Class that captures which lesson we are on.
///
/// This is used to ensure that the `Lesson` and `OptionSelection` are
/// kept up-to-date.
class LessonState extends ChangeNotifier {
  int _currentIndex = 0;
  final List<OptionSelection> _correctSelections = [];
  final List<OptionSelection> _incorrectSelections = [];

  int get currentIndex => _currentIndex;

  List<OptionSelection> get correctSelections => _correctSelections;

  List<OptionSelection> get incorrectSelections => _incorrectSelections;

  void onNext() {
    _currentIndex++;
    notifyListeners();
  }

  void onCorrectSelection(OptionSelection optionSelection) {
    _correctSelections.add(optionSelection);
  }

  void onIncorrectSelection(OptionSelection optionSelection) {
    _incorrectSelections.add(optionSelection);
  }
}
