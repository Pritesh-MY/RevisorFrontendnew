import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReportScreenV3 extends StatefulWidget {
  ReportScreenV3();

  @override
  _ReportScreenV3State createState() => _ReportScreenV3State();
}

class _ReportScreenV3State extends State<ReportScreenV3> with TickerProviderStateMixin {
  AnimationController _confettiController;
  bool hasFavorite = false;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(vsync: this)..addListener(animationListener);
  }

  @override
  Widget build(BuildContext context) {
    final _sliderHeight = Utility.screenHeight(context) * 0.80;
    return Scaffold(
      backgroundColor: AppColors.colorPrimaryLightV2,
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return;
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              SlidingUpPanel(
                maxHeight: _sliderHeight,
                minHeight: Utility.screenHeight(context) / 2,
                parallaxEnabled: true,
                parallaxOffset: .2,
                body: _body(),
                panelBuilder: (sc) => _panel(sc),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                onPanelSlide: (double pos) => setState(() {
                  print('pos ${pos * (_sliderHeight)})} _slider $_sliderHeight');
                  if (pos == _sliderHeight) print('riched');
                  /* _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                      _initFabHeight;*/
                }),
              ),
              Positioned(top: 0, child: header()),
              Positioned(bottom: 0, child: footer(context)),
            ],
          ),
        ),
      ),
    );
  }

  Container footer(BuildContext context) {
    return Container(
      width: Utility.screenWidth(context),
      height: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white /*Color(0xFFF6FBFF)*/,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              offset: Offset(-1, -1),
              blurRadius: 1.5,
            )
          ]),
      child: Row(
        children: [
          horizontalSpace(12),
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: AppColors.white, width: 1),
                    ),
                  ),
                  child: Text('Back', style: textStyleDarkRegular14px600w),
                  onPressed: () {
                    Navigator.pop(context);
                    // _presenter.addToCart(context, widget._cachedBookDetails.bookId, 'Buy');
                    // Navigator.pushNamed(context, Screens.kCartScreen);
                  }),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: FlatButton(
                color: AppColors.colorPrimary,
                height: 50.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: Text(
                  'HOME' /*'$cartButtonText'*/,
                  style: textStyleWhite14px500w,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // _presenter.addToCart(context, widget._cachedBookDetails.bookId, 'Rent');
                }),
          ),
          horizontalSpace(12),
        ],
      ),
    );
  }

  SizedBox header() {
    return SizedBox(
      width: Utility.screenWidth(context),
      height: 60,
      child: Row(
        children: [
          horizontalSpace(10.0),
          RevButton(
              width: 40,
              height: 40,
              radius: 8.0,
              color: AppColors.inputFieldBackgroundColor,
              padding: EdgeInsets.all(6.0),
              child: Image.asset(
                Images.kIconBack,
                width: 24.0,
                height: 24.0,
              ),
              onTap: () => {Navigator.pop(context, true)}),
          Spacer(),
          Text('Report', style: textStyleRegular18pxW600),
          Spacer(),
          RevButton(
            width: 40,
            height: 40,
            radius: 8.0,
            color: Colors.transparent,
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          horizontalSpace(20.0),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        controller: sc,
        children: <Widget>[
          verticalSpace(14.0),
          Container(
            height: 6.0,
            margin: EdgeInsets.symmetric(horizontal: 140.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.textColorBlack,
            ),
          ),
          verticalSpace(30.0),
          Text('Your favourite part', style: textStyleRegular18pxW600),
          verticalSpace(20.0),
          Text('''1. Three classifications:
          Operational Activities
          Financing Activities
          investing Activities''', style: textStyleDarkRegular16px400w)
        ],
      ),
    );
  }

  Container chip() {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      child: Chip(
        backgroundColor: AppColors.moonWhiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.moonWhiteColor),
          borderRadius: BorderRadius.circular(6.0),
        ),
        label: Text(('s417JY')),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        verticalSpace(30.0),
        Image.asset(Images.kPlaceHolderReportO1, width: 260.0),
      ],
    );
  }

  Widget bookInfoRT(String type, String value) => RichText(
        text: TextSpan(
          text: '$type: ',
          style: textStyleDark14px500w,
          children: <TextSpan>[
            TextSpan(
              text: " $value",
              style: textStyleHeader14px500w,
            ),
          ],
        ),
      );

  void animationListener() {
    setState(() => _progressValue = _confettiController.value * 2);
    if (_confettiController.value > 0.5) {
      _confettiController.stop();
      _confettiController.reset();
      Navigator.pushNamed(context, Screens.kForgotPasswordOtpScreen);
    }
  }
}
