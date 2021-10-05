import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 04-03-2021.

class Header extends StatelessWidget {
  final String headerText;
  final EdgeInsets padding;
  final Widget rightWidget;
  final Widget leftWidget;
  final VoidCallback onBackPressed;
  final bool isBackButtonDisable;

  Header({this.headerText, this.padding, this.rightWidget, this.onBackPressed, this.leftWidget, this.isBackButtonDisable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          leftWidget == null
              ? RevButton(
                  width: 40.0,
                  height: 40.0,
                  color: AppColors.inputFieldBackgroundColor,
                  radius: 8.0,
                  child: Center(
                    child: Image.asset(
                      Images.kIconBack,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  onTap: onBackPressed ?? () {
                        if (!(isBackButtonDisable ?? false)) Navigator.pop(context, true);
                      },
                )
              : leftWidget,
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 45.0,
                child: Center(
                    child: Text(
                  '$headerText',
                  style: textStyleRegular16px600px,
                )),
              ),
            ),
          ),
          if (rightWidget != null) rightWidget,
          if (rightWidget == null) horizontalSpace(50.0)
        ],
      ),
    );
  }
}
