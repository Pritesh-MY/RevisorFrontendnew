import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/selectChapter/model/ChapterResponse.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

import 'chapter_view.dart';

/// Created by Pratik Kataria on 19-05-2021.

class ChapterPresenter {
  var tag = 'ChapterPresenter';

  ChapterView _view;
  ApiController _repository = ApiController.getInstance();

  ChapterPresenter(this._view);

  getAllChapters(BuildContext context, int subjectId) async {
    if (await NetworkCheck.check()) {
      var payload = {
        "subjectId": subjectId,
      };
      Dialogs.showLoader(context, 'Please wait getting chapters', '');
      _repository.get(EndPoints.GET_ALL_CHAPTERS, payload: payload, headers: await Utility.header())
        ..then((Response res) async {
          Utility.log(tag, res);
          Dialogs.hideLoader(context);
          ChapterResponse response = ChapterResponse.fromJson(res.data);
          if (response.status)
            _view.onChaptersFetched(response);
          else
            _view.onError(response.message);
        }).catchError((e) {
          Utility.log(tag, e);
          Dialogs.hideLoader(context);
          _view.onError(e);
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }

  getQuizQuestions(BuildContext context, int chapterId) async {
    if (await NetworkCheck.check()) {
      var payload = {
        "chapterId": chapterId /* chapterId */
      };
      Dialogs.showLoader(context, 'Preparing your quiz questions...', '');
      _repository.get(EndPoints.GET_ALL_QUIZ, payload: payload)
        ..then((Response res) async {
          Utility.log(tag, res);
          Dialogs.hideLoader(context);
          QuizResponse response = QuizResponse.fromJson(res.data);
          response.chapterId = chapterId;
          if (response.status)
            _view.onQuizFetched(response);
          else
            _view.onError(response.message);
        });
    }
  }
}
