import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/res/Strings.dart';
import 'package:revisor/ui/forgotPassword/forgot_password_presenter.dart';
import 'package:revisor/ui/forgotPassword/forgot_password_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/resend_response.dart';
import 'package:revisor/ui/signupScreen/model/signup_request.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 21-04-2021.
class ForgotPasswordPhoneNumberScreen extends StatelessWidget implements ForgotPasswordView {
  final GlobalKey<InputFieldState> phoneNumberGlobalKey = GlobalKey<InputFieldState>();
  final SignupRequest _request = SignupRequest();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(15.0),
              Header(headerText: "Forgot Password"),
              verticalSpace(40.4),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 190.0, height: 40.0)),
              verticalSpace(30.0),
              Text('Enter phone number', style: textStyleBlue24px600w),
              Text('To reset password', style: textStyleBlue24px300w),
              verticalSpace(30.0),
              Text(
                'Please enter your Phone number. We’ll send you a confirmation code. We use it to ensure the security of our users.',
                style: textStyleSubText14px400w,
                textAlign: TextAlign.center,
              ),
              verticalSpace(30.0),
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
                onTap: () => forgotPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    if (_request.mobileNumber.isEmpty) {
      phoneNumberGlobalKey.currentState.showError();
      return;
    }

    var presenter = ForgotPasswordPresenter(this);
    presenter.resendOtp(_context, _request);
  }

  @override
  onError(String message) {
    Utility.showErrorToast(_context, message);
  }

  @override
  void onOtpSent(ResendResponse response) {
    _request.otp = response.data.jsonData.otp;
    Navigator.pushNamed(_context, Screens.kForgotPasswordOtpScreen, arguments: _request);
  }

  @override
  void onOtpVerified(LoginResponse response) {
    //ignore
  }

  @override
  void onPasswordChangedSuccessfully(LoginResponse response) {
    //ignore
  }
}
