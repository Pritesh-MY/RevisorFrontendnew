import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/ui/question/assertion_and_reasoning_screen.dart';
import 'package:revisor/ui/question/choose_the_correct_option.dart';
import 'package:revisor/ui/question/drag_drop_question_screen.dart';
import 'package:revisor/ui/question/match_the_following_screen.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/question/multiple_choice_screen.dart';
import 'package:revisor/ui/question/one_word_screen.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/quiz_presenter.dart';
import 'package:revisor/ui/quiz/quiz_view.dart';
import 'package:revisor/ui/quiz/types.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/CachedImageWidget.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/RevButton.dart';

import 'provider/quiz_provider.dart';

class QuizScreen extends StatefulWidget {
  QuizResponse quizResponse;

  QuizScreen(this.quizResponse);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> implements QuizView {
  int questionNumber = 0;
  int answerType = -1;
  int questionType = -1;
  String note = "";
  int totalNumberOfQuestions = 0;
  QuizProvider _provider;
  QuizPresenter _presenter;

  Map questionTypes = {
    AnswerType.SINGLE_SELECT: ChooseTheCorrectOption(),
    AnswerType.MULTIPLE_SELECT: MultipleChoiceQuestion(),
    AnswerType.MATCH: MatchTheFollowingQuestionScreen(),
    AnswerType.DRAG_DROP: DragAndDropQuestionScreen(),
    AnswerType.Text_Input_One_Word: OneWordQuestionScreen(),
    AnswerType.GIVE_REASON: AssertionAndReasoningScreen(),
    QuestionType.FILL_IN_THE_BLANKS: DragAndDropQuestionScreen(),
  };

  @override
  void initState() {
    super.initState();
    var questionData = widget?.quizResponse?.data?.jsonData?.first;
    totalNumberOfQuestions = widget?.quizResponse?.data?.jsonData?.length ?? 0;
    answerType = questionData?.answerType ?? 0;
    questionType = questionData?.questionType ?? 0;

    _provider = Provider.of<QuizProvider>(context, listen: false);
    _provider.setCurrentQuiz(questionData);

    _presenter = QuizPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(10.0),
            Header(headerText: "Question", padding: EdgeInsets.symmetric(horizontal: 20.0)),
            verticalSpace(15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                  text: 'Question ${questionNumber + 1}',
                  style: textStyleDark16px600w,
                  children: [
                    TextSpan(text: "/$totalNumberOfQuestions", style: textStyleSubText12px600w),
                  ],
                ),
              ),
            ),

            if (questionType != QuestionType.MATCH_THE_FOLLOWING)
              Expanded(
                child: ListView(
                  children: [
                    questionNoteUI(),
                    if (_provider?.currentQuizData?.image != null)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: CachedImageWidget(
                          height: 250.0,
                          imageUrl: _provider?.currentQuizData?.image??'https://i.stack.imgur.com/WHhVQ.png',
                          placeHolderImage: "",
                          fit: BoxFit.fill,
                        ),
                      ),
                    questionDescriptionUI(),
                    getQuestion(),
                  ],
                ),
              ),
            if (questionType == QuestionType.MATCH_THE_FOLLOWING)
              Container(
                  constraints: BoxConstraints(
                    minHeight: 50.0,
                    maxHeight: Utility.screenHeight(context) * .32,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('${_provider?.currentQuizData?.questionDescription ?? "NA"}',
                            style: textStyleRegular18pxW500),
                      ),
                    ),
                  )),
            if (questionType == QuestionType.MATCH_THE_FOLLOWING)
              Expanded(child: MatchTheFollowingQuestionScreen()),

            //skip And Continue bottom buttons
            skipContinueWidget()
          ],
        ),
      ),
    );
  }

  Widget getQuestion() {
    print("Answer Type: $answerType");
    var question = questionTypes[answerType];
    if (question != null) return question;
    else return Center(child: Text('BAD QUESTION'));
  }

  Padding questionNoteUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text('Note: ${_provider?.currentQuizData?.questionNote ?? "Answer the following"}',
          style: textStyleSubText12px400w),
    );
  }

  Padding questionDescriptionUI() {
    print("questionNumberAndNote Question Type: $questionType");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (questionType != 4) verticalSpace(10.0),
          if (Types.isSpecialTypeQuestion(questionType))
            Text('${_provider?.currentQuizData?.questionDescription ?? "NA"}',
                style: textStyleRegular18pxW500),
          verticalSpace(10.0),
        ],
      ),
    );
  }

  Container skipContinueWidget() {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(0, -6),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RevButton(
              height: 45.0,
              text: 'SKIP',
              textStyle: textStyleDark16px600w,
              color: AppColors.white,
              onTap: () {
                setState(() {
                  questionNumber++;
                  var questionData = widget?.quizResponse?.data?.jsonData[questionNumber];
                  answerType = questionData.answerType ?? 0;
                  questionType = questionData.questionType ?? 0;
                  _provider.setCurrentQuiz(questionData);

                  print("Question No: $questionNumber Question Type: $questionType");
                  print("Answer Type: ${questionData.answerType}");
                });
              },
            ),
          ),
          horizontalSpace(10.0),
          Expanded(
            child: RevButton(
              width: 45.0,
              text: 'CONTINUE',
              radius: 16.0,
              textStyle: textStyleWhite14px600w,
              onTap: () {
                if (!_provider.answerOptionIsSelectedOrNot) {
                  Utility.showErrorToast(context, "Please answer question");
                  return;
                }
                _provider.answerOptionIsSelectedOrNot = false;

                questionNumber++;

                if (questionNumber >= widget.quizResponse.data.jsonData.length) {
                  _showSubmitQuizDialog();
                  return;
                }

                var questionData = widget?.quizResponse?.data?.jsonData[questionNumber];
                answerType = questionData.answerType ?? 0;
                questionType = questionData.questionType ?? 0;
                _provider.setCurrentQuiz(questionData);

                print("Question Id: ${questionData.questionId}");
                print("Question No: $questionNumber Question Type: $questionType");
                print("Answer Type: ${questionData.answerType}");
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitQuizDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(20.0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Quiz Completed", style: textStyleDark16px600w),
                    verticalSpace(8.0),
                    Text(
                      "Would you like submit quiz and\nget your report on your registered email",
                      style: textStyleDark14px500w,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                          ),
                        ),
                        horizontalSpace(20.0),
                        OutlinedButton(
                          onPressed: () async {
                            var userId = (await AuthUser.getInstance().getCurrentUser())
                                .userCredentials
                                .data
                                .jsonData
                                .userId;

                            var map = _provider.answers;
                            List<UserAnswers> userAnswerList = [];
                            for (var keys in map.keys) userAnswerList.add(map[keys]);

                            QuizAnswerRequest request = QuizAnswerRequest()
                              ..chapterId = widget.quizResponse.chapterId
                              ..userId = userId
                              ..userAnswers = userAnswerList;
                            _presenter.postQuizAnswers(context, request);
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onQuizUploadedSuccessfully() {}

  @override
  void onReportCreatedSuccessfully() {
    Utility.showSuccessToastB(context, "Report sent on email");
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

/*ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Container(
    height: 10,
    child: LinearProgressIndicator(
      value: 0.60, // percent filled
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
      backgroundColor: AppColors.colorPrimaryLightV2,
    ),
  ),
),*/
