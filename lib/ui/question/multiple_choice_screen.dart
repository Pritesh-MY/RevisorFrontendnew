import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/utils/Utility.dart';

/// 🔥 MVP Architecture 🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 00-00-2021.

class MultipleChoiceQuestion extends StatefulWidget {
  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  List<AnswerOption> options = [];
  List<AnswerOption> correctOptionsList = [];

  List<Widget> choices = [];
  QuizProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<QuizProvider>(context, listen: false);
    var answerOptions = _provider.currentQuizData.answerOption;
    options.addAll(answerOptions);
    correctOptionsList.addAll(answerOptions.where((element) => element.position != null).toList());
  }

  @override
  Widget build(BuildContext context) {
    optionsBuilder();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ...choices,
        ],
      ),
    );
  }

  optionsBuilder() {
    choices.clear();
    for (AnswerOption answer in options) {
      choices.add(Container(
        constraints: BoxConstraints(
          minHeight: 52.0,
        ),
        margin: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
            color: answer.isSelected ? AppColors.colorSecondaryDark : AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.inputFieldBackgroundColor)),
        child: InkWell(
          onTap: () {
            setState(() {
              answer.isSelected = !answer.isSelected;
              checkAnswer();
            });
          },
          child: Row(
            children: [
              horizontalSpace(20.0),
              Image.asset(
                Images.kIconCheckbox,
                height: 24.0,
                color: answer.isSelected ? AppColors.white : AppColors.inputFieldBackgroundColor,
              ),
              horizontalSpace(20.0),
              Expanded(
                child: Text(
                  '${answer.answerOption}',
                  style: answer.isSelected ? textStyleWhite16px400w : textStyleRegular16px500w,
                ),
              ),
              horizontalSpace(20.0),
            ],
          ),
        ),
      ));
    }
  }

  void checkAnswer() {
    QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
    var questionId = _provider.currentQuizData.questionId;
    _provider.answerOptionIsSelectedOrNot = true;

    var userSelectedOptions = options.where((element) => element.isSelected);

    var listCorrectAndIncorrectOptions = userSelectedOptions.map<bool>((e) {
      var firstOptionWhereUserSelectedOptionContainsInCorrectOption = correctOptionsList
          .firstWhere((element) => element.answerOption == e.answerOption, orElse: () => null);
      return firstOptionWhereUserSelectedOptionContainsInCorrectOption != null;
    }).toList();

    var answerIsCorrectOrNot = userSelectedOptions.length == correctOptionsList.length && listCorrectAndIncorrectOptions.firstWhere((options) => options == false, orElse: () => true);

    _provider.addAnswer(UserAnswers(questionId, _provider.currentQuizData.conceptNumber, answerIsCorrectOrNot));
  }
}

/*MultipleChoiceQuestionResponse('Deposit ratio'),
MultipleChoiceQuestionResponse('Statutory liquidity ratio'),
MultipleChoiceQuestionResponse('Legal reserve ratio'),
MultipleChoiceQuestionResponse('Cash reserve ratio')*/
