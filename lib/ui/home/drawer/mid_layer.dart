import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/Utility.dart';

// ignore: must_be_immutable
class MidLayer extends StatefulWidget {
  @override
  _MidLayerState createState() => _MidLayerState();
}

class _MidLayerState extends State<MidLayer> {
  String currentSelectedScreen = Screens.kResetPasswordScreen;
  String firstName = "";
  String email = "";

  BaseProvider _provider;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    var data = (await AuthUser.getInstance().getCurrentUser())?.userCredentials?.data?.jsonData;
    firstName = data?.firstName;
    email = data?.username;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<BaseProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(30.0),
          Row(
            children: [
              Image.asset(Images.kPlaceHolderProfile, height: 90),
              horizontalSpace(20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$firstName", style: textStyleWhite14px500w),
                  Text("$email", style: textStyleWhite14px400w2l),
                ],
              ),
            ],
          ),
          verticalSpace(40.0),
          Expanded(
            child: ListView(
              children: [
                drawerRowBuilder(Images.kIconEditProfile, Screens.kEditProfileScreen, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconTestHistory, Screens.kScreenTestHistory, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconAboutUs, Screens.kScreenAboutUs, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconRateUs, Screens.kScreenRateUs, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconTnc, Screens.kScreenTnc, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconReferFriend, Screens.kScreenReferFriend, context: context),
                verticalSpace(30.0),
                drawerRowBuilder(Images.kIconSettings, "Logout", context: context),
                verticalSpace(30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerRowBuilder(String iconRes, String screen, {BuildContext context}) {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            Image.asset(iconRes, width: 24, height: 24),
            horizontalSpace(12.0),
            Text(screen, style: textStyleWhite14px500w),
          ],
        ),
      ),
      onTap: () async {
        if (_provider.isOpen) _provider.close();
        await Future.delayed(Duration(milliseconds: 300));
        // _provider.currentScreen = screen;

        switch (screen) {
          case Screens.kScreenTestHistory:
            _provider.currentScreen = screen;
            break;
          case Screens.kEditProfileScreen:
            Navigator.pushNamed(context, Screens.kEditProfileScreen);
            break;
          case "Logout":
            await AuthUser.getInstance().logout();
            Navigator.popAndPushNamed(context, Screens.kLoginScreen);
            break;
          default:
            Utility.showToast(context, 'not available');
        }
      },
    );
  }
}
