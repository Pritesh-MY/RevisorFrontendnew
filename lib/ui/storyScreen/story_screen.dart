import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';
import 'package:revisor/widget/RevOutlineButton.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utility.log("tag", Utility.screenWidth(context));
    Utility.log("tag", Utility.screenHeight(context));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.kStoryImgOne),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Image.asset(Images.kStoryImgThree)),
                    Expanded(child: Image.asset(Images.kStoryImgTwo)),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0.0,
              left: 0.0,
              top: 20.0,
              child: Image.asset(Images.kAppLogo, height: 50.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomSheetWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  bottomSheetWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      child: Container(
        height: Utility.screenHeight(context) * .42,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            verticalSpace(Utility.screenHeight(context) * 0.03),
            Text('Hello!', style: Responsive.textStyleBlue24px600wRes(context)),
            Text('Welcome to Revisor', style: Responsive.textStyleBlue24px300w(context)),
            Text('Try any chapter for free and get one pager customised report for the chapter',
                style: Responsive.textStyleSubText14px400w(context)),
            verticalSpace(Utility.screenHeight(context) * 0.02),
            RevButton(
              height: Utility.screenHeight(context) * 0.070,
              text: "Existing Student",
              textStyle: Responsive.textStyleWhite14px400w(context),
              onTap: () => Navigator.popAndPushNamed(context, Screens.kLoginScreen),
            ),
            verticalSpace(Utility.screenHeight(context) * 0.02),
            RevOutlineButton(
              height: Utility.screenHeight(context) * 0.070,
              text: "New to Revisor",
              textStyle: Responsive.textStylePrimary14px400wc(context),
              onTap: () => Navigator.popAndPushNamed(context, Screens.kOnboardingScreen),
            ),
            verticalSpace(Utility.screenHeight(context) * 0.02),
          ],
        ),
      ),
    );
  }
}
