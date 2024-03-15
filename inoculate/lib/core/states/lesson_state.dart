import 'package:flutter/foundation.dart';
import 'package:inoculate/modules/lesson_snippet/option_selection.dart';

/// Class that captures which lesson we are on.
///
/// This is used to ensure that the `Lesson` and `OptionSelection` are
/// kept up-to-date.
class LessonState extends ChangeNotifier {
  int _currentIndex = 0;

  int _falsePositives = 0;
  int _falseNegatives = 0;
  int _truePositives = 0;
  int _trueNegatives = 0;

  final List<OptionSelection> _correctSelections = [];
  final List<OptionSelection> _incorrectSelections = [];

  int get currentIndex => _currentIndex;
  int get falsePositives => _falsePositives;
  int get falseNegatives => _falseNegatives;
  int get truePositives => _truePositives;
  int get trueNegatives => _trueNegatives;

  List<OptionSelection> get correctSelections => _correctSelections;

  List<OptionSelection> get incorrectSelections => _incorrectSelections;

  void onNext() {
    _currentIndex++;
    notifyListeners();
  }

  void onCorrectSelection(OptionSelection optionSelection, bool? isAccurate) {
    _correctSelections.add(optionSelection);

    if (isAccurate == null) {
      return;
    }

    if (isAccurate) {
      _truePositives++;
    } else {
      _trueNegatives++;
    }
  }

  void onIncorrectSelection(OptionSelection optionSelection, bool? isAccurate) {
    _incorrectSelections.add(optionSelection);

    if (isAccurate == null) {
      return;
    }

    if (isAccurate) {
      _falsePositives++;
    } else {
      _falseNegatives++;
    }
  }
}
