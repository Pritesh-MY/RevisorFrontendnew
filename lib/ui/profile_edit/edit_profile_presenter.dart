import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/ui/profile_edit/edit_profile_view.dart';
import 'package:revisor/ui/profile_edit/model/edit_profile_request.dart';
import 'package:revisor/ui/profile_edit/model/edit_profile_response.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class EditProfilePresenter {
  var tag = 'SelectStreamPresenter';

  EditProfileView _view;
  ApiController _repository = ApiController.getInstance();

  EditProfilePresenter(this._view);

  updateProfile(BuildContext context, int userId, EditProfileRequest request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Updating profile ...', '');
      _repository.put(EndPoints.PUT_UPDATE_PROFILE, body: request.toJson(), payload: {"id": userId.toString()}, headers: await Utility.header())
        ..then((Response res) async {
          Utility.log(tag, res);
          Dialogs.hideLoader(context);
          EditProfileResponse response = EditProfileResponse.fromJson(res.data);
          _view.onProfileUpdated(response);
        }).catchError((e) {
          Utility.log(tag, e);
          Dialogs.hideLoader(context);
          _view.onError(e.toString());
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }
}
