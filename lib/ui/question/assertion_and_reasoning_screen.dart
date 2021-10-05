import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/utils/Utility.dart';

class AssertionAndReasoningScreen extends StatefulWidget {
  @override
  _AssertionAndReasoningScreenState createState() => _AssertionAndReasoningScreenState();
}

class _AssertionAndReasoningScreenState extends State<AssertionAndReasoningScreen> {
  List options = [];
  List reasons = [];

  List<Widget> choices = [];
  List<Widget> reasoningChoices = [];

  AnswerOption currentSelected;
  var currentReasonSelected;
  String correctReason;

  @override
  void initState() {
    super.initState();
    QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
    options.addAll(_provider.currentQuizData.answerOption);
    reasons.addAll(_provider.currentQuizData.giveReasonOption.map((e) => e).toList());
    correctReason = _provider.currentQuizData.giveReasonCorrectOption;
  }

  @override
  Widget build(BuildContext context) {
    optionsBuilder();
    reasoningOptionsBuilder();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...choices,
                verticalSpace(10.0),
                if (isShowGiveReason) Text('Give reason:', style: textStyleBlue12px600w),
                if (isShowGiveReason) ...reasoningChoices,
              ],
            ),
          ),
        ),
      ],
    );
  }

  get isShowGiveReason => currentSelected?.position != null;

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
            QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
            if (currentSelected == null) setState(() => currentSelected = question);
            _provider.answerOptionIsSelectedOrNot = !isShowGiveReason;
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

  reasoningOptionsBuilder() {
    reasoningChoices.clear();
    for (String question in reasons) {
      reasoningChoices.add(
        Container(
          height: 52.0,
          margin: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: currentReasonSelected == question ? AppColors.colorSecondaryDark : AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.inputFieldBackgroundColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: () {
              setState(() => currentReasonSelected = question);
              QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
              _provider.answerOptionIsSelectedOrNot = true;
              var questionId = _provider.currentQuizData.questionId;
              var conceptNumber = _provider.currentQuizData.conceptNumber;
              var isUserAnswerCorrect = question == correctReason;
              _provider.addAnswer(UserAnswers(questionId, conceptNumber, isUserAnswerCorrect));
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$question',
                style: currentReasonSelected == question ? textStyleWhite16px400w : textStyleRegular16px500w,
              ),
            ),
          ),
        ),
      );
    }
  }
}
