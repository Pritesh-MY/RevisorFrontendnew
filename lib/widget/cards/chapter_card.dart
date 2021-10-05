import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/ui/selectChapter/chapters_presenter.dart';
import 'package:revisor/ui/selectChapter/model/ChapterResponse.dart';
import 'package:revisor/utils/Utility.dart';

import '../CachedImageWidget.dart';

class ChapterCard extends StatelessWidget {
  Chapters _terms;
  ChapterPresenter _presenter;

  ChapterCard(Chapters _term, ChapterPresenter _presenter, {Key key}) : super(key: key) {
    this._terms = _term;
    this._presenter = _presenter;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _presenter.getQuizQuestions(context, _terms.chapterId),
      child: Container(
        height: 80.0,
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
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              horizontalSpace(20.0),
              Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.colorPrimaryLightV2,
                  borderRadius: BorderRadius.circular(16.0),
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
                  imageUrl: '${EndPoints.BASE_URL}/${_terms.image}',
                  placeHolderImage: Images.kIconChapter,
                ),
              ),
              horizontalSpace(20.0),
              Expanded(
                child: Text('${_terms.chapterName}',
                    style: textStyleDark16px600w, maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
