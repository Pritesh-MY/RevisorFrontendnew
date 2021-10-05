import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/ErrorResponse.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/resend_response.dart';
import 'package:revisor/ui/signupScreen/model/signup_request.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

import 'forgot_password_view.dart';

/// Created by Pratik Kataria on 19-05-2021.

class ForgotPasswordPresenter {
  var tag = 'SignupPresenter';

  ForgotPasswordView _view;
  ApiController _repository = ApiController.getInstance();

  ForgotPasswordPresenter(this._view) : super();

  resendOtp(BuildContext context, SignupRequest _request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Sending OTP ...', 'Verifying');

      var body = {
        "countryCode": "+91",
        "mobileNumber": _request.mobileNumber,
      };

      _repository.post(EndPoints.SEND_OTP, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          ResendResponse response = ResendResponse.fromJson(res.data);
          Utility.log(tag, res);
          if (response.status)
            _view.onOtpSent(response);
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

  verifyOtp(BuildContext context, SignupRequest _request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Verifying OTP ...', 'Verifying');

      var body = {
        "mobileNumber": _request.mobileNumber,
        "countryCode": "+91",
        "otp": _request.otp,
      };

      _repository.post(EndPoints.VERIFY_OTP, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);
          if (response.status)
            _view.onOtpVerified(response);
          else
            _view.onError(response.message);
        }).catchError((e) {
          Dialogs.hideLoader(context);
          if (e is DioError) {
            ErrorResponse response = ErrorResponse.fromJson(e.response.data);
            _view.onError(response.message);
          } else {
            _view.onError(e?.message ?? "Something went wrong");
          }
        });
    }
  }

  resetPassword(BuildContext context, SignupRequest _request) async {
    if (await NetworkCheck.check()) {
      var body = {
        "mobileNumber": _request.mobileNumber,
        "newPassword": _request.password,
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
