import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';

class SubjectCardV3 extends StatelessWidget {
  const SubjectCardV3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Container(
        height: 116.0,
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
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
        child: Row(
          children: [
            Container(
              width: 95.0,
              height: 95.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.kPlaceHolderStream),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Text('Business Studies', style: textStyleBlue16px600w),
            ),
          ],
        ),
      ),
    );
  }
}
