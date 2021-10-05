import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/res/Strings.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/otp_sent_response.dart';
import 'package:revisor/ui/signupScreen/model/resend_response.dart';
import 'package:revisor/ui/signupScreen/model/signup_request.dart';
import 'package:revisor/ui/signupScreen/signup_presenter.dart';
import 'package:revisor/ui/signupScreen/signup_view.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/user/CurrentUser.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 21-04-2021.
class PhoneNumberScreen extends StatelessWidget implements SignupView {
  final SignupRequest _request;
  final GlobalKey<InputFieldState> phoneNumberGlobalKey = GlobalKey<InputFieldState>();
  BuildContext context;

  PhoneNumberScreen(this._request);

  SignupPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(Utility.screenHeight(context) * 0.020),
              Center(child: Text('Mobile', style: textStyleRegular16px600px)),
              verticalSpace(40.4),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 132.0, height: 52.0)),
              verticalSpace(30.0),
              Text(
                'Enter',
                style: textStyleBlue24px600w,
              ),
              Text(
                'Your phone number',
                style: textStyleBlue24px300w,
              ),
              verticalSpace(60.0),
              InputField(
                leftIcon: Images.kIconPhone,
                placeHolderText: 'Phone',
                errorMessage: 'Please enter phone',
                inputType: InputType.MOBILE,
                onTextChange: (String val) => _request.mobileNumber = val,
                key: phoneNumberGlobalKey,
              ),
              verticalSpace(20.0),
              RevButton(
                color: AppColors.colorPrimary,
                textStyle: textStyleWhiteRegular16px,
                text: kContinue,
                onTap: () => doSignup(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doSignup(BuildContext context) {
    if (_request.mobileNumber.isEmpty) {
      phoneNumberGlobalKey.currentState.showError();
      return;
    }

    phoneNumberGlobalKey.currentState.resetFocus();
    _presenter = SignupPresenter(this);
    _presenter.doSignup(context, _request);
    // _presenter.sentOtp(context, _request.mobileNumber);
  }

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onOtpSend(OtpSentResponse response) {
    _request.otp = response.data.jsonData.otp;
    Navigator.pushNamed(context, Screens.kVerifyOtpScreen, arguments: _request);
  }

  @override
  void onResent(ResendResponse response) {
    _request.otp = response.data.jsonData.otp;
    Navigator.pushNamed(context, Screens.kVerifyOtpScreen, arguments: _request);
  }

  @override
  void onUserVerified(LoginResponse response) {
    var currentUser = CurrentUser()..userCredentials = response;
    AuthUser.getInstance().login(currentUser);
    Navigator.of(context).pushNamedAndRemoveUntil(Screens.kSelectStream, ModalRoute.withName('/'));
  }

  @override
  void onSocialLoginSuccess(LoginResponse response) {}
}
