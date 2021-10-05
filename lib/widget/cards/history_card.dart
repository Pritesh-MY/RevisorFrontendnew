import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/utils/Utility.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pushNamed(context, Screens.kReportScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              // box-shadow: 0px 10px 30px 0px #0000000D;
              color: AppColors.colorSecondary.withOpacity(0.1),
              blurRadius: 20.0,
              spreadRadius: 5.0,
              offset: Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Economics | Term 2', style: textStyleDark14px500w),
            verticalSpace(12.0),
            Row(
              children: [
                Image.asset(
                  Images.kPlaceHolderStream,
                  width: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text('Chapter 01', style: textStyleRegular18pxW600),
                ),
                Spacer(),
                Icon(Icons.check_box_rounded, color: AppColors.textColorGreen)
              ],
            ),
            verticalSpace(12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Played on', style: textStyle12px500w),
                    Text('20 Aug 2021', style: textStyleDark14px500w),
                  ],
                ),
                Text('View report', style: textStyleBlue12px600w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
