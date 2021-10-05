import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 22-03-2021.

class VerifyOtpPhoneNumber extends StatefulWidget {
  final SignupRequest request;

  VerifyOtpPhoneNumber(this.request /*this.request*/);

  @override
  _VerifyOtpPhoneNumberState createState() => _VerifyOtpPhoneNumberState();
}

class _VerifyOtpPhoneNumberState extends State<VerifyOtpPhoneNumber> implements SignupView {
  String firstDigit = "-";
  String secondDigit = "-";
  String thirdDigit = "-";
  String fourthDigit = "-";
  String tag = 'VerifyPhoneNumber';

  int counter = 30;
  Timer _timer;
  SignupPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SignupPresenter(this);
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
                  verticalSpace(Utility.screenHeight(context) * 0.020),
                  Center(child: Text('Verify Mobile', style: textStyleRegular16px600px)),
                  verticalSpace(40.4),
                  Align(
                      alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 132.0, height: 52.0)),
                  verticalSpace(30.0),
                  Text(
                    'Verify',
                    style: textStyleBlue24px600w,
                  ),
                  Text(
                    'Your phone number',
                    style: textStyleBlue24px300w,
                  ),
                  verticalSpace(30.0),
                  verticalSpace(15.0),
                  Center(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Enter the 4 digit verification code that has been sent to your mobile number\n',
                        style: textStyleSubText14px400w,
                        children: [
                          TextSpan(text: "${widget.request.mobileNumber}", style: textStyleBlue16px600w),
                          WidgetSpan(
                            child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(" (Change)", style: textStylePrimary16px600w)),
                          )
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Please verify your email address to continue.',
                      textAlign: TextAlign.center,
                      style: textStyleDark12px400w,
                    ),
                  ),
                  verticalSpace(20.0),
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
                    text: kContinue,
                    textStyle: textStyleWhite16px600w,
                    onTap: () {
                      String sOtp = (firstDigit + secondDigit + thirdDigit + fourthDigit).replaceAll(RegExp(r'[^\w\s]+'), '');
                      if (sOtp.isEmpty) {
                        onError('Please enter OTP first');
                        return;
                      }

                      if (sOtp.length < 4) {
                        onError('Invalid OTP');
                        return;
                      }

                      if (sOtp == widget.request.otp) {
                        _presenter.verifyOtp(context, widget.request);
                        return;
                      }

                      onError('Incorrect OTP');
                    },
                  ),
                  verticalSpace(10.0),
                  RevButton(
                    text: 'Resend OTP ${(counter > 1 && counter < 30) ? '($counter)' : ''}',
                    textStyle: textStyleBlue16px600w,
                    color: AppColors.white,
                    onTap: () {
                      if (counter == 30) {
                        startCounter();
                        _presenter.resendOtp(context, widget.request.mobileNumber);
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
        if (this.mounted) {
          setState(() {
            if (counter > 0)
              counter--;
            else {
              timer.cancel();
              _timer = null;
              counter = 30;
            }
          });
        }

      });
    }
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onOtpSend(OtpSentResponse response) {}

  @override
  void onResent(ResendResponse response) {
    setState(() {
      firstDigit = "-";
      secondDigit = "-";
      thirdDigit = "-";
      fourthDigit = "-";
    });
    widget.request.otp = response.data.jsonData.otp;
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
