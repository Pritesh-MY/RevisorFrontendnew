import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/ErrorResponse.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/socialLogin/social_login_view.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';

/// Created by Pratik Kataria on 19-05-2021.

class SocialLoginPresenter {
  var tag = 'SocialLoginPresenter';

  SocialLoginView _view;
  ApiController _repository = ApiController.getInstance();

  SocialLoginPresenter(this._view);

  socialLogin(BuildContext context, String token, int type) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Social Logging ...', 'Verifying');
      var body = {
        "access_Token": token,
        "providerName": type,
      };
      _repository.post(EndPoints.SOCIAL_LOGIN, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);
          if (response.status) _view.onSocialLoginSuccess(response);
          else _view.onError(response.message);
        }).catchError((e) {
          Dialogs.hideLoader(context);
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
