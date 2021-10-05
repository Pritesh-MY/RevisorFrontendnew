import 'package:flutter/material.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';

class DragDropQuestionProvider extends ChangeNotifier {
  Set<String> optionsUsed = {};
  List<AnswerOption> options = [];
  Set<String> remainingOptions;
  String currentSelection = "";
  int dropCounts;

  Map answers = {};

  void updateOptions(List<AnswerOption> option) {
    options.addAll(option);
  }

  DragDropQuestionProvider() {
    remainingOptions = Set.from(options);
  }

  void use(String option) {
    print(optionsUsed);
    optionsUsed.add(option);
    if (optionsUsed.length > dropCounts) {
      int revIndex = optionsUsed.length;
      while (revIndex > dropCounts) {
        optionsUsed.remove(optionsUsed.first);
        revIndex--;
      }
    }
    notifyListeners();
  }

  void onDroppedValueChanged(String option) {
    optionsUsed.remove(option);
    notifyListeners();
  }
}
