import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/utils/Utility.dart';

import 'provider/drag_drop_question_provider.dart';

class ImageBasedFillInTheBlanksQuestion extends StatefulWidget {
  @override
  _ImageBasedFillInTheBlanksQuestionState createState() => _ImageBasedFillInTheBlanksQuestionState();
}

class _ImageBasedFillInTheBlanksQuestionState extends State<ImageBasedFillInTheBlanksQuestion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DragDropQuestionProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          verticalSpace(10.0),
          Align(
            alignment: Alignment.center,
            child: Image.asset(Images.kPlaceHolderImgBasedQuestion, height: 150.0),
          ),
          verticalSpace(10.0),
          RichText(
            text: TextSpan(
              style: textStylePrimary18pxW500,
              children: <InlineSpan>[
                ...dragTargetBox('''1. _ helps in buying the goods and services.
                            
2. We can _ it for the future.

3. It helps in accumulating''')
              ],
            ),
            textAlign: TextAlign.start,
          ),
          verticalSpace(20.0),
     /*     Consumer<DragDropQuestionProvider>(
            builder: (_, provider, __) {
              return Wrap(
                  runSpacing: 10.0,
                  children: provider.options
                      .map((emoji) => Draggable<String>(
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
                                      child: Text(emoji,
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
                                    child: Center(child: Text(emoji, style: textStyleDark14px500w)),
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
                                  child: Center(child: Text(emoji, style: textStyleSecondaryLight14px500w)),
                                ),
                                horizontalSpace(10.0),
                              ],
                            ),
                          ))
                      .toList());
            },
          ),*/
        ],
      ),
    );
  }

  dragTargetBox(String data) {
    var provider = Provider.of<DragDropQuestionProvider>(context, listen: false);
    List<String> s = data.split('_');
    List<InlineSpan> widget = [];
    provider.dropCounts = s.length;

    int position = 0;
    for (String word in s) {
      print("rebuild");
      widget.add(TextSpan(text: word, style: textStyleRegular16px500w));
    /*  widget.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0), child: BorderBoxDragTarget(provider.options[position])),
      ));*/
    }

    return widget;
  }
}

// ignore: must_be_immutable
class BorderBoxDragTarget extends StatefulWidget {
  final String answer;

  BorderBoxDragTarget(this.answer);

  @override
  _BorderBoxDragTargetState createState() => _BorderBoxDragTargetState();
}

class _BorderBoxDragTargetState extends State<BorderBoxDragTarget> {
  DragDropQuestionProvider provider;

  String dropped;

  @override
  Widget build(BuildContext context) {
    int answerLength = widget.answer.length;
    // String answerHint = '.' * answerLength;
    double answerWidth = answerLength * 15.0;
    provider = Provider.of<DragDropQuestionProvider>(context, listen: false);

    return _buildDragTarget(answerWidth);
  }

  Widget _buildDragTarget(double answerWidth) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        print(incoming);
        var color = AppColors.colorPrimaryLightV2;
        if (dropped != null) {
          return DottedBorder(
            dashPattern: [6, 0, 0, 5],
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              width: answerWidth,
              color: color,
              child: Center(child: Text(dropped, style: textStyleDark14px500wH08)),
            ),
          );
        } else {
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
        return true;
      },
      onAccept: (data) {
        dropped = data;
        provider.use(dropped);
      },
      onLeave: (data) {},
    );
  }
}
