import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/ErrorResponse.dart';
import 'package:revisor/ui/changePassword/change_password_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

class ChangePasswordPresenter {
  var tag = 'ChangePasswordPresenter';

  ChangePasswordView _view;
  ApiController _repository = ApiController();

  ChangePasswordPresenter(this._view) : super();

  resetPassword(BuildContext context, String mobileNumber, String password) async {
    if (await NetworkCheck.check()) {
      var body = {
        "mobileNumber": mobileNumber,
        "newPassword": password,
      };

      Dialogs.showLoader(context, 'Resetting password ...', 'Verifying');
      _repository.post(EndPoints.CHANGE_PASSWORD, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);
          if (response.status)
            _view.onPasswordChangedSuccessfully(response);
          else
            _view.onError(response.message);
        }).catchError((e) {
          Dialogs.hideLoader(context);
          Utility.log(tag, e);
          if (e is DioError) {
            ErrorResponse response = ErrorResponse.fromJson(e.response.data);
            _view.onError(response.message);
          } else {
            _view.onError(e.message);
          }
        });
    }
  }
}
