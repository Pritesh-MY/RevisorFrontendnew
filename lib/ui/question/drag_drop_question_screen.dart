import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/utils/Utility.dart';

import 'provider/drag_drop_question_provider.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 00-00-2021.

class DragAndDropQuestionScreen extends StatefulWidget {
  @override
  _DragAndDropQuestionScreenState createState() => _DragAndDropQuestionScreenState();
}

class _DragAndDropQuestionScreenState extends State<DragAndDropQuestionScreen> {
  QuizProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<QuizProvider>(context, listen: false);
    var dragDropProvider = Provider.of<DragDropQuestionProvider>(context, listen: false);
    dragDropProvider.updateOptions(_provider.currentQuizData.answerOption.map<AnswerOption>((e) => e).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(10.0),
          RichText(
            text: TextSpan(
              style: textStylePrimary18pxW500,
              children: <InlineSpan>[...dragTargetBox("${_provider.currentQuizData.questionDescription}")],
            ),
            textAlign: TextAlign.start,
          ),
          verticalSpace(10.0),
          Consumer<DragDropQuestionProvider>(
            builder: (_, provider, __) {
              return Wrap(
                  runSpacing: 10.0,
                  children: provider.options
                      .map((emoji) => Draggable<AnswerOption>(
                            data: emoji,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30.0,
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: provider.optionsUsed.contains(emoji)
                                            ? AppColors.colorSecondaryLight
                                            : AppColors.colorSecondary),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                      child: Text(emoji?.answerOption,
                                          style: provider.optionsUsed.contains(emoji)
                                              ? textStyleSecondaryLight14px500w
                                              : textStyleDark14px500w)),
                                ),
                                horizontalSpace(10.0),
                              ],
                            ),
                            feedback: Material(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30.0,
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.colorSecondary),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(child: Text(emoji?.answerOption, style: textStyleDark14px500w)),
                                  )
                                ],
                              ),
                            ),
                            childWhenDragging: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30.0,
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.colorSecondaryLight),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child:
                                      Center(child: Text(emoji?.answerOption, style: textStyleSecondaryLight14px500w)),
                                ),
                                horizontalSpace(10.0),
                              ],
                            ),
                          ))
                      .toList());
            },
          ),
        ],
      ),
    );
  }

  dragTargetBox(String data) {
    var dropProvider = Provider.of<DragDropQuestionProvider>(context, listen: false);
    List<String> s = data.split('_');
    List<InlineSpan> widget = [];
    dropProvider.dropCounts = s.length;
    int blankCount = s.length - 1;

    int position = 0;
    for (String word in s) {
      dropProvider.answers[position] = -1;

      widget.add(TextSpan(text: word, style: textStyleRegular16px500w));
      if (blankCount > 0)
        widget.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: BorderBoxDragTarget(position, dropProvider.options[position]),
          ),
        ));
      position++;
      blankCount--;
    }

    return widget;
  }
}

// ignore: must_be_immutable
class BorderBoxDragTarget extends StatefulWidget {
  final AnswerOption answer;
  final int position;

  BorderBoxDragTarget(this.position, this.answer);

  @override
  _BorderBoxDragTargetState createState() => _BorderBoxDragTargetState();
}

class _BorderBoxDragTargetState extends State<BorderBoxDragTarget> {
  DragDropQuestionProvider provider;
  AnswerOption dropped;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int answerLength = widget?.answer?.answerOption?.length ?? 10;
    // String answerHint = '.' * answerLength;
    double answerWidth = answerLength * 15.0;
    provider = Provider.of<DragDropQuestionProvider>(context, listen: false);

    return _buildDragTarget(answerWidth);
  }

  Widget _buildDragTarget(double answerWidth) {
    return DragTarget<AnswerOption>(
      builder: (BuildContext context, List<AnswerOption> incoming, List rejected) {
        print(incoming);
        var color = AppColors.colorPrimaryLightV2;
        if (dropped != null) {
          provider.answers[widget.position] = dropped.position;
          print("fill-up : ${provider.answers}");

          return DottedBorder(
            dashPattern: [6, 0, 0, 5],
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              width: answerWidth,
              color: color,
              child: Center(child: Text(dropped?.answerOption, style: textStyleDark14px500wH08)),
            ),
          );
        } else {
          provider.answers[widget.position] = -1;
          print("fill-up : ${provider.answers}");

          return DottedBorder(
            dashPattern: [6, 0, 0, 5],
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              width: answerWidth,
              child: Text(""),
            ),
          );
        }
      },
      onWillAccept: (data) {
        print("accepted");
        return true;
      },
      onAccept: (data) {
        dropped = data;
        provider.use(dropped?.answerOption);
      },
      onLeave: (data) {},
    );
  }
}
