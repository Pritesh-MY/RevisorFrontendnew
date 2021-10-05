import 'package:flutter/material.dart';
import 'package:revisor/ui/question/model/quiz_response.dart' as qResponse;
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';

class QuizProvider extends ChangeNotifier {
  qResponse.JsonData currentQuizData;
  QuizAnswerRequest quizAnswerRequest = QuizAnswerRequest();
  bool _answerOptionIsSelectedOrNot = false;

  void setCurrentQuiz(qResponse.JsonData data) {
    currentQuizData = data;
    notifyListeners();
  }


  qResponse.JsonData getCurrentQuiz() {
    return currentQuizData;
  }

  bool get answerOptionIsSelectedOrNot => _answerOptionIsSelectedOrNot;

  set answerOptionIsSelectedOrNot(bool value) {
    _answerOptionIsSelectedOrNot = value;
    notifyListeners();
  }

  Map<int, UserAnswers> answers = {};

  void addAnswer(UserAnswers userAnswers) {
    answers[userAnswers.questionId] = userAnswers;

    answers.forEach((key, value) {
      print('Question ID: $key');
      print('Correct: ${value.isCorrect}');
      print('---------------------------');
    });
  }
}
