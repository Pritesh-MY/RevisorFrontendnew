import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/rev_error_parser.dart';
import 'package:revisor/ui/login/login_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class LoginPresenter {
  var tag = 'LoginPresenter';

  LoginView _view;
  ApiController _repository = ApiController.getInstance();

  LoginPresenter(this._view);

  doLogin(BuildContext context, String username, String password) async {
    if (await NetworkCheck.check()) {
      var body = {
        "username": username,
        "password": password,
      };
      Dialogs.showLoader(context, 'Logging in...', 'Verifying');
      _repository.post(EndPoints.LOGIN, body: body)
        ..then((Response res) async {
          Utility.log(tag, res.data);
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);

          if (response.status)
            _view.onLoginSuccess(response, context);
          else
            _view.onError(response.message);
        }).catchError((e) {
          Utility.log(tag, e.toString());
          Dialogs.hideLoader(context);
          RevErrorParser.parseError(e, _view);
        });
    }
  }
}
