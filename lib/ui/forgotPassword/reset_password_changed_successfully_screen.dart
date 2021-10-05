import 'package:flutter/material.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 21-04-2021.
class ResetPasswordChangedSuccessfullyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    popAfter3sec(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(15.4),
              Center(child: Text('Reset Password', style: textStyleRegular16px600px)),
              verticalSpace(40.4),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 190.0, height: 40.0)),
              verticalSpace(30.0),
              Text('Password', style: textStyleBlue24px600w),
              Text('Reset successfully', style: textStyleBlue24px300w),
              verticalSpace(50.0),
              Container(
                height: 150.0,
                child: Image.asset(Images.kIconCheckboxPlaceholder),
              ),
            ],
          ),
        ),
      ),
    );
  }

  popAfter3sec(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Screens.kLoginScreen, ModalRoute.withName('/'));
    });
  }
}
