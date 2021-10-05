import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 00-00-2021.

class ChooseTheCorrectOption extends StatefulWidget {
  ChooseTheCorrectOption();

  @override
  _ChooseTheCorrectOptionState createState() => _ChooseTheCorrectOptionState();
}

class _ChooseTheCorrectOptionState extends State<ChooseTheCorrectOption> {
  List options = [];
  List<Widget> choices = [];

  AnswerOption currentSelected;

  @override
  void initState() {
    super.initState();
    QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
    options.addAll(_provider.currentQuizData.answerOption);
  }

  @override
  Widget build(BuildContext context) {
    // optionsBuilder();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer<QuizProvider>(
        builder: (_, provider, __) {
          print('Choose the correct option: consumer rebuild');
          return Column(
            children: [
              ...provider.currentQuizData.answerOption
                  .map((question) => Container(
                        constraints: BoxConstraints(
                          minHeight: 52.0,
                        ),
                        // height: 52.0,
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(
                          color: currentSelected == question ? AppColors.colorSecondaryDark : AppColors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: AppColors.inputFieldBackgroundColor),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                        child: InkWell(
                          onTap: () {
                            setState(() => currentSelected = question);
                            checkAnswer();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${question.answerOption}',
                              style: currentSelected == question
                                  ? textStyleWhite16px400w
                                  : textStyleRegular16px500w,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          );
        },
      ),
    );
  }

  void checkAnswer() {
    QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
    _provider.answerOptionIsSelectedOrNot = true;
    var questionId = _provider.currentQuizData.questionId;
    _provider.addAnswer(UserAnswers(questionId, _provider.currentQuizData.conceptNumber, currentSelected?.position != null));
  }
}

/*

  optionsBuilder() {
    choices.clear();
    for (AnswerOption question in options) {
      choices.add(Container(
        height: 52.0,
        margin: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          color: currentSelected == question ? AppColors.colorSecondaryDark : AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.inputFieldBackgroundColor),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: InkWell(
          onTap: () {
            setState(() => currentSelected = question);
            checkAnswer();
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${question.answerOption}',
              style: currentSelected == question ? textStyleWhite16px400w : textStyleRegular16px500w,
            ),
          ),
        ),
      ));
    }
  }

*/
