import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/ui/selectStream/model/stream_response.dart';
import 'package:revisor/ui/selectStream/provider/subject_stream_provider.dart';
import 'package:revisor/widget/CachedImageWidget.dart';

class SubjectCard extends StatelessWidget {
  final JsonData model;

  const SubjectCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<SubjectStreamProvider>(context, listen: false);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => addressProvider.update(model),
      child: Container(
        width: 150.0,
        height: 150.0,
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border:
              Border.all(color: (model?.isSelected ?? false) ? AppColors.colorPrimary : AppColors.white, width: 2.0),
          boxShadow: [
            BoxShadow(
              // box-shadow: 0px 10px 30px 0px #0000000D;
              color: (model?.isSelected ?? false)
                  ? AppColors.colorPrimary.withOpacity(0.18)
                  : AppColors.colorSecondary.withOpacity(0.1),
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
              child: Text('${model.streamName}', style: textStyleBlue16px600w),
            ),
            Container(
              width: 70.0,
              height: 70.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    // box-shadow: 0px 10px 30px 0px #0000000D;
                    color: AppColors.colorPrimary.withOpacity(0.18),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 2),
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
