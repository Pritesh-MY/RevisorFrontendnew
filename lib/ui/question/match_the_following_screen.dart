import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/utils/Utility.dart';

/// This is the main application widget.
class MatchTheFollowingQuestionScreen extends StatefulWidget {
  const MatchTheFollowingQuestionScreen({Key key}) : super(key: key);

  @override
  _MatchTheFollowingQuestionScreenState createState() => _MatchTheFollowingQuestionScreenState();
}

class _MatchTheFollowingQuestionScreenState extends State<MatchTheFollowingQuestionScreen> {
  final List<String> _question = [];
  final List<AnswerOption> rightOption = [];
  final List<AnswerOption> correctSequence = [];

  LinkedScrollControllerGroup _controllers;
  ScrollController _letters;
  ScrollController _numbers;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _letters = _controllers.addAndGet();
    _numbers = _controllers.addAndGet();

    var _provider = Provider.of<QuizProvider>(context, listen: false);
    var answerOptionList = _provider.currentQuizData.answerOption.map((e) => e).toList();
    _question.addAll(_provider?.currentQuizData?.leftOption?.map((e) => "$e")?.toList() ?? []);
    rightOption.addAll(answerOptionList);
    rightOption.shuffle();
    correctSequence.addAll(answerOptionList);
    correctSequence.sort((a, b) => a.position.compareTo(b.position));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0, -2),
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: ListView.builder(
                controller: _letters,
                itemCount: _question.length,
                itemBuilder: (_, i) => Container(
                  height: 52.0,
                  color: AppColors.colorSecondary,
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Center(child: Text(_question[i], style: textStyleWhite12px500w)),
                ),
              ),
            ),
          ),
          horizontalSpace(20.0),
          Flexible(
            child: ReorderableListView(
              scrollController: _numbers,
              children: <Widget>[
                for (int index = 0; index < rightOption.length; index++)
                  Container(
                    key: Key('$index'),
                    color: Colors.amber,
                    height: 52.0,
                    margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                    child: ListTile(
                      title: Text(
                        '${rightOption[index].answerOption}',
                        style: textStyleDark12px600w,
                      ),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.drag_handle),
                      ),
                    ),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) newIndex -= 1;
                  final AnswerOption item = rightOption.removeAt(oldIndex);
                  rightOption.insert(newIndex, item);
                });
                checkAnswers();
              },
            ),
          ),
        ],
      ),
    );
  }

  void checkAnswers() {
    QuizProvider _provider = Provider.of<QuizProvider>(context, listen: false);
    _provider.answerOptionIsSelectedOrNot = true;
    var questionId = _provider.currentQuizData.questionId;
    var isAnswerCorrectOrNot = true;
    for (int x = 0; x < correctSequence.length; x++) {
      if (correctSequence[x].answerOption != rightOption[x].answerOption) {
        isAnswerCorrectOrNot = false;
        break;
      }
    }
    _provider.addAnswer(UserAnswers(questionId, _provider.currentQuizData.conceptNumber, isAnswerCorrectOrNot));
  }
}

/*


            Row(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      for (int index = 0; index < _question.length; index++)
                        Container(
                          height: 52.0,
                          color: AppColors.colorSecondary,
                          margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                          child: Center(child: Text(_question[index], style: textStyleWhite12px500w)),
                        ),
                    ],
                  ),
                ),
                horizontalSpace(20.0),
                Flexible(
                  child: ReorderableListView(
                    children: <Widget>[
                      for (int index = 0; index < _answer.length; index++)
                        Container(
                          key: Key('$index'),
                          color: Colors.amber,
                          height: 52.0,
                          margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                          child: ListTile(
                            title: Text(
                              '${_answer[index]}',
                              style: textStyleDark12px600w,
                            ),
                            trailing: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(Icons.drag_handle),
                            ),
                          ),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final String item = _answer.removeAt(oldIndex);
                        _answer.insert(newIndex, item);
                      });
                    },
                  ),
                ),
              ],
            ),



* */
