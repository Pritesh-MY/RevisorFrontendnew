import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/history/history_screen.dart';
import 'package:revisor/ui/home/home_screen.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/ui/profile/profile_screen.dart';
import 'package:revisor/utils/Utility.dart';

import 'KitBottomNavigation.dart';

// ignore: must_be_immutable
class Base extends StatelessWidget {
  Map<String, Widget> allDestinations;
  BuildContext context;
  BaseProvider provider;

  Base() {
    initState();
  }

  void initState() async {
    allDestinations = {
      Screens.kHomeScreen: HomeScreen(),
      Screens.kScreenTestHistory: HistoryScreen(),
      Screens.kProfileScreen: ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      provider = Provider.of<BaseProvider>(context);
      provider.addListener(onSideNavigationClicked);
    }
    return Consumer<BaseProvider>(builder: (_, baseProvider, __) {
      return AnimatedContainer(
        transform: Matrix4Transform()
            .translate(x: baseProvider.xoffSet)
            .scale(baseProvider.scaleFactor, origin: Offset(0, Utility.screenHeight(context) / 2))
            .matrix4,
        duration: Duration(milliseconds: 250),
        child: WillPopScope(
            onWillPop: () {
              if (baseProvider.isOpen) baseProvider.close();
              if (baseProvider.currentScreen != Screens.kHomeScreen)
                baseProvider.currentScreen = Screens.kHomeScreen;
              return;
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(baseProvider.isOpen ? 12.0 : 0.0),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: KitBottomNavigation(),
                body: SafeArea(
                  child: IndexedStack(
                    index: allDestinations.values.toList().indexOf(allDestinations[baseProvider.currentScreen]),
                    children: allDestinations.values.toList(),
                  ),
                ),
              ),
            )),
      );
    });
  }

  void onSideNavigationClicked() {
    if (Screens.kHomeScreen == provider.currentScreen || Screens.kProfileScreen == provider.currentScreen) {
      print(provider.currentScreen);
    }
  }
}
