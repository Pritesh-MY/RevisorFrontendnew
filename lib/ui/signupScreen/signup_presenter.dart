import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/api/ErrorResponse.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/otp_sent_response.dart';
import 'package:revisor/ui/signupScreen/model/resend_response.dart';
import 'package:revisor/ui/signupScreen/model/signup_request.dart';
import 'package:revisor/ui/signupScreen/signup_view.dart';
import 'package:revisor/ui/socialLogin/social_login_presenter.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';

/// Created by Pratik Kataria on 19-05-2021.

class SignupPresenter extends SocialLoginPresenter {
  var tag = 'SignupPresenter';

  SignupView _view;
  ApiController _repository = ApiController.getInstance();

  SignupPresenter(this._view) : super(_view);

  doSignup(BuildContext context, SignupRequest _request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Creating your account ...', 'Verifying');
      _repository.post(EndPoints.SIGN_UP, body: _request.toJson())
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);
          if (response.status)
            _view.onUserVerified(response);
          else
            _view.onError(response.message);
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

  sentOtp(BuildContext context, String mobileNumber) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Sending OTP ...', 'Verifying');

      var body = {
        "countryCode": "+91",
        "mobileNumber": mobileNumber,
      };

      _repository.post(EndPoints.SEND_OTP, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          OtpSentResponse response = OtpSentResponse.fromJson(res.data);
          if (response.status) _view.onOtpSend(response);
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

  resendOtp(BuildContext context, String mobileNumber) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Resending OTP ...', 'Verifying');

      var body = {
        "countryCode": "+91",
        "mobileNumber": mobileNumber,
      };

      _repository.post(EndPoints.SEND_OTP, body: body)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          ResendResponse response = ResendResponse.fromJson(res.data);
          if (response.status) _view.onResent(response);
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

  verifyOtp(BuildContext context, SignupRequest _request) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Verifying OTP ...', 'Verifying');

      _repository.post(EndPoints.VERIFY_OTP, body: _request.toJson())
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          LoginResponse response = LoginResponse.fromJson(res.data);
          if (response.status)
            _view.onUserVerified(response);
          else
            _view.onError(response.message);
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
