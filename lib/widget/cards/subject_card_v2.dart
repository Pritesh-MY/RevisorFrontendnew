import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/model/home_subject_response.dart';

import '../CachedImageWidget.dart';

class SubjectCardV2 extends StatelessWidget {
  final Subject model;

  const SubjectCardV2(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => Navigator.pushNamed(context, Screens.kChapterScreen, arguments: model.subjectId),
      child: Container(
        width: 140.0,
        height: 140.0,
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('${model.subjectName}', style: textStyleBlue16px600w),
            ),
            Container(
              width: 55.0,
              height: 55.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    // box-shadow: 0px 10px 30px 0px #0000000D;
                    color: AppColors.colorPrimary.withOpacity(0.18),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: CachedImageWidget(
                width: 40.0,
                height: 40.0,
                imageUrl: '${EndPoints.BASE_URL}/${model.image}',
                placeHolderImage: Images.kIconNetworkErrorPlaceHolder,
              ),
            )
          ],
        ),
      ),
    );
  }
}
