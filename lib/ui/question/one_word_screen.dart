import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/widget/InputField.dart';

class OneWordQuestionScreen extends StatefulWidget {
  @override
  _OneWordQuestionScreenState createState() => _OneWordQuestionScreenState();
}

class _OneWordQuestionScreenState extends State<OneWordQuestionScreen> {
  String correctAnswerLowerCase;
  int questionId;
  QuizProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<QuizProvider>(context, listen: false);
    correctAnswerLowerCase = _provider?.currentQuizData?.answerOption?.first?.answerOption?.toLowerCase() ?? "";
    questionId = _provider?.currentQuizData?.questionId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: oneWordInput(),
    );
  }

  InputField oneWordInput() {
    return InputField(
      placeHolderText: 'one word answer',
      errorMessage: 'Please enter password',
      onTextChange: (String val) {
        _provider.answerOptionIsSelectedOrNot = val.isNotEmpty;
        bool isCorrect = correctAnswerLowerCase.isNotEmpty && val.toLowerCase().trim() == correctAnswerLowerCase;
        _provider.addAnswer(UserAnswers(questionId, _provider.currentQuizData.conceptNumber, isCorrect));
      },
    );
  }
}
