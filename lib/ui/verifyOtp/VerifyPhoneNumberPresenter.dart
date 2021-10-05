/// Created by Pratik Kataria on 19-05-2021.

class VerifyPhoneNumberPresenter {
/*  var tag = 'SignupPresenter';
  VerificationView _signupView;

  VerifyPhoneNumberPresenter(this._signupView);

  ApiController _repository = ApiController.getInstance();

  doVerification(SignupRequest request, String otp, BuildContext context) async {
    if (await NetworkCheck.check()) {
      var requestV1 = request.toMap();
      requestV1["otp"] = otp;
      Dialogs.showLoader(context, 'Please wait while Verifying Otp', 'Verifying');
      _repository.post(EndPoints.SIGN_UP, body: requestV1)
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          SignupResponseV1 responseV1 = SignupResponseV1.fromJson(res.data);
          if (responseV1.success)
            _signupView.onVerificationSuccess(responseV1);
          else
            _signupView.onVerificationFailed('verification failed: ${responseV1.message}');
        }).catchError((e) {
          Dialogs.hideLoader(context);
          DioErrorParser.parseError(e, _signupView);
        });
    }
  }

  resend(SignupRequest request, BuildContext context) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Please wait while receiving Otp', 'Resending Otp');
      _repository.post(EndPoints.SEND_OTP, body: request.toMap()).then(
        (Response res) async {
          Dialogs.hideLoader(context);
          if (res.data["success"]) {
            _signupView.onResend(res.data['message']);
          }
        },
      ).catchError((e) {
        Dialogs.hideLoader(context);
        DioErrorParser.parseError(e, _signupView);
      });
    }
  }*/
}
