import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/ui/changePassword/change_password_presenter.dart';
import 'package:revisor/ui/changePassword/change_password_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 21-08-2021.
class ChangePasswordScreen extends StatelessWidget implements ChangePasswordView {
  final GlobalKey<InputFieldState> newPasswordGlobalKey = GlobalKey<InputFieldState>();
  final GlobalKey<InputFieldState> confirmPasswordGlobalKey = GlobalKey<InputFieldState>();
  final GlobalKey<InputFieldState> oldPasswordGlobalKey = GlobalKey<InputFieldState>();

  var confirmPassword = '';
  var newPassword = '';
  var oldPassword = '';

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
              Header(headerText: "Change Password"),
              verticalSpace(20.0),
              InputField(
                leftIcon: Images.kIconLock,
                placeHolderText: 'Old Password',
                errorMessage: 'Please enter old password',
                isPassword: true,
                onTextChange: (String val) => oldPassword = val,
                key: oldPasswordGlobalKey,
              ),
              verticalSpace(20.0),
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
                text: 'UPDATE',
                onTap: () => resetPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    if (newPassword.isEmpty && confirmPassword.isEmpty & oldPassword.isEmpty) {
      newPasswordGlobalKey.currentState.showError();
      confirmPasswordGlobalKey.currentState.showError();
      oldPasswordGlobalKey.currentState.showError();
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

    if (oldPassword.isEmpty) {
      oldPasswordGlobalKey.currentState.showError();
      return;
    }

    if (confirmPassword != newPassword) {
      onError('Confirm password and new password must be same');
      return;
    }

    // widget._response.password = confirmPassword;
    var presenter = ChangePasswordPresenter(this);
    presenter.resetPassword(_context, "", confirmPassword);
  }

  @override
  onError(String message) {
    Utility.showErrorToast(_context, message);
  }

  @override
  void onPasswordChangedSuccessfully(LoginResponse response) {
    Utility.showToast(null, "Password changed successfully");
    Navigator.pop(_context);
    Navigator.pop(_context);
  }
}
