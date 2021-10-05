import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/ui/profile/model/profile_response.dart';
import 'package:revisor/ui/profile/profile_view.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class ProfilePresenter {
  var tag = 'ChapterPresenter';

  ProfileView _view;
  ApiController _repository = ApiController.getInstance();

  ProfilePresenter(this._view);

  getProfile(BuildContext context) async {
    if (await NetworkCheck.check()) {
      var authUser = (await (AuthUser.getInstance().getCurrentUser())).userCredentials;
      var payload = {"userId": authUser?.data?.jsonData?.userId.toString() ?? "-1"};
      _repository.get(EndPoints.GET_PROFILE_BY_UID, payload: payload, headers: await Utility.header())
        ..then((Response res) async {
          ProfileResponse response = ProfileResponse.fromJson(res.data);
          if (response.status)
            _view.onProfileInformationFetched(response);
          else
            _view.onError(response.message);
        }).catchError((e) {
          _view.onError(e.toString());
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }
}
