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
class ResetPasswordScreen extends StatefulWidget {
  final SignupRequest _response;

  ResetPasswordScreen(this._response);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> implements ForgotPasswordView {
  final GlobalKey<InputFieldState> newPasswordGlobalKey = GlobalKey<InputFieldState>();

  final GlobalKey<InputFieldState> confirmPasswordGlobalKey = GlobalKey<InputFieldState>();

  var confirmPassword = '';

  var newPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(15.0),
              Header(headerText: "Reset Password"),
              verticalSpace(40.4),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 190.0, height: 40.0)),
              verticalSpace(30.0),
              Text(
                'Enter phone number',
                style: textStyleBlue24px600w,
              ),
              Text(
                'To reset password',
                style: textStyleBlue24px300w,
              ),
              verticalSpace(30.0),
              Text(
                'Please enter your Phone number. We’ll send you a confirmation code. We use it to ensure the security of our users.',
                style: textStyleSubText14px400w,
                textAlign: TextAlign.center,
              ),
              verticalSpace(30.0),
              InputField(
                leftIcon: Images.kIconLock,
                placeHolderText: 'New Password',
                errorMessage: 'Please enter new password',
                isPassword: true,
                onTextChange: (String val) => newPassword = val,
                key: newPasswordGlobalKey,
              ),
              verticalSpace(20.0),
              InputField(
                leftIcon: Images.kIconLock,
                placeHolderText: 'Re-Enter New Password',
                errorMessage: 'Please enter confirm password',
                isPassword: true,
                onTextChange: (String val) => confirmPassword = val,
                key: confirmPasswordGlobalKey,
              ),
              verticalSpace(20.0),
              RevButton(
                color: AppColors.colorPrimary,
                textStyle: textStyleWhiteRegular16px,
                text: kContinue,
                onTap: () => resetPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    if (newPassword.isEmpty && confirmPassword.isEmpty) {
      newPasswordGlobalKey.currentState.showError();
      confirmPasswordGlobalKey.currentState.showError();
      return;
    }

    if (newPassword.isEmpty) {
      newPasswordGlobalKey.currentState.showError();
      return;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordGlobalKey.currentState.showError();
      return;
    }

    if (confirmPassword != newPassword) {
      onError('Confirm password and new password must be same');
      return;
    }

    widget._response.password = confirmPassword;
    var presenter = ForgotPasswordPresenter(this);
    presenter.resetPassword(context, widget._response);
  }

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onOtpSent(ResendResponse response) {
    //ignore
  }

  @override
  void onOtpVerified(LoginResponse response) {
    //ignore
  }

  @override
  void onPasswordChangedSuccessfully(LoginResponse response) {
    Navigator.pushNamed(context, Screens.kResetPasswordChangedSuccessfullyScreen);
  }
}
