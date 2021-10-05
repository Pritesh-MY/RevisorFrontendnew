import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/utils/Utility.dart';

class KitBottomNavigation extends StatelessWidget {
  String currentSelected = Screens.kHomeScreen;
  BaseProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<BaseProvider>(context, listen: false);

    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: AppColors.colorPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            offset: Offset(-1, -1),
            blurRadius: 1.5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navigationButton(Screens.kHomeScreen, Images.kIconHome, Images.kIconPhone),
          navigationButton(Screens.kScreenTestHistory, Images.kIconDocument, Images.kIconPhone, context: context),
          navigationButton(Screens.kProfileScreen, Images.kIconPerson, Images.kIconPhone),
          // navigationButton(Screens.kProfileScreen, Images.kProfile, Images.kPersonFilled),
        ],
      ),
    );
  }

  navigationButton(String incomingScreen, String icon, String inActiveIcon, {BuildContext context}) {
    return Consumer<BaseProvider>(builder: (_, baseProver, __) {
      return InkWell(
        onTap: () {
          /*   if (incomingScreen == Screens.kCartScreen)
                Navigator.pushNamed(context, Screens.kCartScreen);
              else*/
          provider.currentScreen = incomingScreen;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                icon,
                color: provider.currentScreen == incomingScreen ? AppColors.white : AppColors.colorPrimaryLightV3,
                width: 20.0,
                height: 20.0,
              ),
            ),
            verticalSpace(4.0),
            Text('$incomingScreen'.toUpperCase(), style: textStyleWhite12px400w),
          ],
        ),
      );
    });
  }
}
