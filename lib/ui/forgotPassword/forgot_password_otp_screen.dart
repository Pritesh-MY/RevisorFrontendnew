import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 22-03-2021.

class ForgotPasswordOtpScreen extends StatefulWidget {
  final SignupRequest request;

  ForgotPasswordOtpScreen(this.request);

  @override
  _ForgotPasswordOtpScreenState createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> implements ForgotPasswordView {
  String firstDigit = "-";
  String secondDigit = "-";
  String thirdDigit = "-";
  String fourthDigit = "-";
  String tag = 'VerifyPhoneNumber';

  int counter = 30;
  Timer _timer;

  ForgotPasswordPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ForgotPasswordPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(15.0),
                  Header(headerText: "Forgot Password"),
                  verticalSpace(40.4),
                  Image.asset(Images.kAppLogo, width: 190.0, height: 40.0),
                  verticalSpace(30.0),
                  Text('Enter 4 digit code', style: textStyleBlue24px600w),
                  Text('To reset password', style: textStyleBlue24px300w),
                  verticalSpace(30.0),
                  Text(
                    'Please enter your Phone number. We’ll send you a confirmation code. We use it to ensure the security of our users.',
                    style: textStyleSubText14px400w,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(30.0),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RevButton(
                            width: 68.0,
                            height: 68.0,
                            text: firstDigit,
                            textStyle: textStyleDarkRegular16px400w,
                            color: AppColors.inputFieldBackgroundColor,
                          ),
                          RevButton(
                            width: 68.0,
                            height: 68.0,
                            text: secondDigit,
                            textStyle: textStyleDarkRegular16px400w,
                            color: AppColors.inputFieldBackgroundColor,
                          ),
                          RevButton(
                            width: 68.0,
                            height: 68.0,
                            text: thirdDigit,
                            textStyle: textStyleDarkRegular16px400w,
                            color: AppColors.inputFieldBackgroundColor,
                          ),
                          RevButton(
                            width: 68.0,
                            height: 68.0,
                            text: fourthDigit,
                            textStyle: textStyleDarkRegular16px400w,
                            color: AppColors.inputFieldBackgroundColor,
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          maxLength: 4,
                          style: textStyleDarkRegular16px400w,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixStyle: TextStyle(color: AppColors.textColor),
                          ),
                          onChanged: (String val) => enterNumber(val),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  RevButton(
                    height: 50.0,
                    text: kContinue,
                    textStyle: textStyleWhite16px600w,
                    onTap: () {
                      String sOtp =
                          (firstDigit + secondDigit + thirdDigit + fourthDigit).replaceAll(RegExp(r'[^\w\s]+'), '');
                      if (sOtp.isEmpty) {
                        onError('Please enter otp first');
                        return;
                      }

                      if (sOtp.length < 4) {
                        onError('Invalid otp');
                        return;
                      }

                      if (sOtp == widget.request.otp) {
                        // _presenter.verifyOtp(context, widget.request);
                        onOtpVerified(null);
                        return;
                      }

                      onError('Incorrect Otp');
                    },
                  ),
                  verticalSpace(10.0),
                  RevButton(
                    text: 'Resend code ${(counter > 1 && counter < 30) ? '($counter)' : ''}',
                    textStyle: textStyleBlue16px600w,
                    color: AppColors.white,
                    onTap: () {
                      if (counter == 30) {
                        startCounter();
                        _presenter.resendOtp(context, widget.request);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void enterNumber(String value) {
    setState(() {
      firstDigit = "-";
      secondDigit = "-";
      thirdDigit = "-";
      fourthDigit = "-";
    });

    for (int i = 1; i <= value.length; i++) {
      print('value of i $i');
      switch (i) {
        case 1:
          setState(() {
            firstDigit = value[i - 1];
          });
          break;

        case 2:
          setState(() {
            secondDigit = value[i - 1];
          });
          break;
        case 3:
          setState(() {
            thirdDigit = value[i - 1];
          });
          break;
        case 4:
          setState(() {
            fourthDigit = value[i - 1];
          });
          break;
      }
    }
  }

  void startCounter() {
    counter = 30;
    if (_timer == null) {
      Utility.log(tag, 'timer initiated');
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (counter > 0)
            counter--;
          else {
            timer.cancel();
            _timer = null;
            counter = 30;
          }
        });
      });
    }
  }

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onOtpSent(ResendResponse response) {
    setState(() {
      firstDigit = "-";
      secondDigit = "-";
      thirdDigit = "-";
      fourthDigit = "-";

      if (counter == 0) {
        counter = 30;
      }
    });
  }

  @override
  void onOtpVerified(LoginResponse response) {
    Navigator.popAndPushNamed(context, Screens.kResetPasswordScreen, arguments: widget.request);
  }

  @override
  void onPasswordChangedSuccessfully(LoginResponse response) {
    //ignore
  }
}
