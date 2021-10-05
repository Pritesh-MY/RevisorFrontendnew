import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/RevButton.dart';

class FillInTheBlanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(15.0),
            Header(headerText: "Question", padding: EdgeInsets.symmetric(horizontal: 20.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(35.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 10,
                      child: LinearProgressIndicator(
                        value: 0.60, // percent filled
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
                        backgroundColor: AppColors.colorPrimaryLightV2,
                      ),
                    ),
                  ),
                  verticalSpace(24.0),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    text: TextSpan(
                      text: 'Question 1',
                      style: textStyleDark16px600w,
                      children: [
                        TextSpan(text: "/10", style: textStyleSubText12px600w),
                      ],
                    ),
                  ),
                  verticalSpace(10.0),
                  Text('Note: Only one answer is correct per numbered item', style: textStyleSubText12px400w),
                  verticalSpace(10.0),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        ...blankExtractor("The ratio _ total deposits that a _ bank has to _ with _ is called:")
                      ],
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 70.0,
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
                      width: 68.0,
                      height: 68.0,
                      text: 'SKIP',
                      textStyle: textStyleDark16px600w,
                      color: AppColors.white,
                    ),
                  ),
                  horizontalSpace(10.0),
                  Expanded(
                    child: RevButton(
                      width: 68.0,
                      text: 'CONTINUE',
                      radius: 16.0,
                      textStyle: textStyleWhite14px600w,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  blankExtractor(String data) {
    List<String> s = data.split('_');
    List<InlineSpan> widget = [];
    int blankCount = s.length;

    for (String word in s) {
      widget.add(TextSpan(text: word, style: textStyleRegular18pxW500));
      print(blankCount);
      if (blankCount > 0)
        widget.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Blanks("1234567890"),
        ));
      blankCount--;
    }

    return widget;
  }
}

class Blanks extends StatelessWidget {
  final String answer;

  Blanks(this.answer);

  @override
  Widget build(BuildContext context) {
    String value = "";
    int answerLength = answer.length;
    // String answerHint = '.' * answerLength;
    double answerWidth = answerLength * 15.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: answerWidth,
          child: TextFormField(
            maxLines: null,
            cursorColor: AppColors.textColorBlack,
            cursorRadius: Radius.circular(12.0),
            cursorWidth: 2.0,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.colorPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 3,
            ),
            autofocus: false,
            maxLength: answerLength,
            onChanged: (text) {
              value = text;
            },
            decoration: new InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: -5),
              counterText: '',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: textStyleRegular18pxW500,
            ),
          ),
        ),
        verticalSpace(4.0),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: answerWidth,
          lineThickness: 2.0,
          dashLength: 9.0,
          dashColor: Colors.black,
          dashGapLength: 5.0,
          dashGapColor: Colors.transparent,
          dashGapRadius: 0.0,
        )
      ],
    );
  }
}
