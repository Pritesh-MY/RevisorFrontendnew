import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/selectChapter/chapter_view.dart';
import 'package:revisor/ui/selectChapter/chapters_presenter.dart';
import 'package:revisor/ui/selectChapter/model/ChapterResponse.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/cards/chapter_card.dart';

class SelectChapterScreen extends StatefulWidget {
  int subjectId;

  SelectChapterScreen(this.subjectId);

  @override
  _SelectChapterScreenState createState() => _SelectChapterScreenState();
}

class _SelectChapterScreenState extends State<SelectChapterScreen> implements ChapterView {
  List<Widget> cList = [];
  ChapterPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ChapterPresenter(this);
    presenter.getAllChapters(context, widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(headerText: "Select Chapter"),
              verticalSpace(35.0),
              Text('TERM 2', style: textStyleDark16px600w),
              Expanded(
                child: ListView(
                  children: [
                    ...cList,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onChaptersFetched(ChapterResponse response) {
    cList.clear();
    var terms = response.data.jsonData.chapters;
    for (Chapters term in terms) cList.add(ChapterCard(term, presenter));
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onQuizFetched(QuizResponse quizResponse) {
    if (quizResponse?.data?.jsonData?.isEmpty??true) {
      onError("No data found");
      return;
    }

    Navigator.pushNamed(context, Screens.kQuizScreen, arguments: quizResponse);
  }
}
