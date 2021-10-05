import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/rev_error_parser.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';
import 'package:revisor/ui/quiz/model/quiz_answer_request.dart';
import 'package:revisor/ui/quiz/model/report_response.dart';
import 'package:revisor/ui/quiz/quiz_view.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class QuizPresenter {
  var tag = 'QuizPresenter';

  QuizView _view;
  ApiController _repository = ApiController.getInstance();

  QuizPresenter(this._view);

  postQuizAnswers(BuildContext context, QuizAnswerRequest request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Verifying answers...', 'Verifying');
      _repository.post(EndPoints.POST_QUIZ_ANSWERS, body: request.toJson())
        ..then((Response res) async {
          Utility.log(tag, res.data);
          Dialogs.hideLoader(context);

          QuizResponse response = QuizResponse.fromJson(res.data);
          if (response.status)
            generateReport(context, request);
          else
            _view.onError(response.message);
        }).catchError((e) {
          Utility.log(tag, e.toString());
          Dialogs.hideLoader(context);
          RevErrorParser.parseError(e, _view);
        });
    }
  }

  generateReport(BuildContext context, QuizAnswerRequest request) async {
    if (await NetworkCheck.check()) {
      var body = {
        "userId": request.userId,
        "chapterId": request.chapterId,
      };

      Dialogs.showLoader(context, 'Generating report ...', 'Verifying');
      _repository.post(EndPoints.CREATE_QUIZ_REPORT, body: body)
        ..then((Response res) async {
          Utility.log(tag, res.data);
          Dialogs.hideLoader(context);

          ReportResponse response = ReportResponse.fromJson(res.data);
          if (response.status) _view.onReportCreatedSuccessfully();
          else _view.onError(response.message);

        /*  QuizResponse response = QuizResponse.fromJson(res.data);
          if (response.status) _view.onQuizUploadedSuccessfully();
          else _view.onError(response.message);*/
        }).catchError((e) {
          Utility.log(tag, e.toString());
          Dialogs.hideLoader(context);
          RevErrorParser.parseError(e, _view);
        });
    }
  }
}
