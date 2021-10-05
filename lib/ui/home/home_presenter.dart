import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/ui/home/home_view.dart';
import 'package:revisor/ui/home/model/home_subject_response.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class HomePresenter {
  var tag = 'HomePresenter';

  HomeView _view;
  ApiController _repository = ApiController.getInstance();

  HomePresenter(this._view);

  getSubjects(BuildContext context) async {
    if (await NetworkCheck.check()) {
      num userId = (await AuthUser.getInstance().getCurrentUser()).userCredentials.data.jsonData.userId;
      var query = {"userId": userId.toString()};
      Dialogs.showLoader(context, 'Getting your subjects ...', 'Verifying');

      _repository.get(EndPoints.GET_ALL_SUBJECT_BY_UID, payload: query, headers: await Utility.header())
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          Utility.log(tag, res.data);
          HomeSubjectResponse response = HomeSubjectResponse.fromJson(res.data);
          if (response.status) _view.onSubjectFetched(response);
          else if (response.message == "No Subjects Found. Please select your stream first") _view.onNoSubjectsFound(response.message);
          else _view.onError(response.message);
        }).catchError((e) {
          Utility.log(tag, e);
          Dialogs.hideLoader(context);
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }
}
