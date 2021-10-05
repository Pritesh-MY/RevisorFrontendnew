import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var _pages = [];
  PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _pages.add(pageBuilder(
        Images.kPlaceHolderO1, "Hello!", "Try any chapter for free and get one pager customised report for the chapter"));
    _pages.add(pageBuilder(Images.kPlaceHolderO2, "Select Your Stream",
        "Try any chapter for free and get one pager customised report for the chapter"));
    _pages.add(pageBuilder(Images.kPlaceHolderO3, "Select Your Subject",
        "Try any chapter for free and get one pager customised report for the chapter"));
    _pages.add(pageBuilder(Images.kPlaceHolderO4, "Answer The Question",
        "Try any chapter for free and get one pager customised report for the chapter"));
    _pages.add(pageBuilder(Images.kPlaceHolderO5, "Get Your Result",
        "Try any chapter for free and get one pager customised report for the chapter"));

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_controller.page != _pages.length - 1) {
        _controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear);
      } else {
        print('canceled');
        timer.cancel();
      }
    });

    _controller.addListener(onPageChangeListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              verticalSpace(30.0),
              Image.asset(Images.kAppLogo, height: 40.0),
              verticalSpace(30.0),
              Expanded(
                child: PageView.builder(
                  itemCount: _pages.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index % _pages.length];
                  },
                ),
              ),
              verticalSpace(30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [...dotes()],
              ),
              if (_currentPage != _pages.length - 1)
                RevButton(
                  width: 75.0,
                  text: "Skip",
                  textStyle: textStyleSubText14px600w,
                  color: AppColors.white,
                  onTap: () {
                    _timer?.cancel();
                    if (_controller.page == _pages.length - 1) {
                      Navigator.popAndPushNamed(context, Screens.kLoginScreen);
                      return;
                    }
                    _controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear).whenComplete(() =>
                        _controller
                            .nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear)
                            .whenComplete(
                                () => _controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear))
                            .whenComplete(
                                () => _controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.linear))
                            .whenComplete(() => Navigator.popAndPushNamed(context, Screens.kLoginScreen)));
                  },
                ),
              if (_currentPage == _pages.length - 1)
                RevButton(
                  color: AppColors.colorPrimary,
                  textStyle: textStyleWhiteRegular16px,
                  margin: EdgeInsets.only(top: 20.0),
                  text: 'GET STARTED',
                  onTap: () {
                    _timer?.cancel();
                    return Navigator.popAndPushNamed(context, Screens.kLoginScreen);
                  },
                ),
              verticalSpace(50.0),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> dotes() {
    List<Widget> dotes = [];
    print("page length ${_pages.length}");
    for (int i = 0; i < _pages.length; i++)
      dotes.add(Container(
        width: i == _currentPage ? 12.0 : 6.0,
        height: 6.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ));

    return dotes;
  }

  pageBuilder(String image, String title, String description) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Image.asset(image),
          ),
        ),
        verticalSpace(30.0),
        Text('$title', style: textStyleBlue20px600w),
        Text('$description', style: textStyleSubText14px400w, textAlign: TextAlign.center),
      ],
    );
  }

  void onPageChangeListener() {
    setState(() => _currentPage = _controller.page.toInt());
  }
}
