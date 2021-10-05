import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/home_presenter.dart';
import 'package:revisor/ui/home/home_view.dart';
import 'package:revisor/ui/home/model/home_subject_response.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';
import 'package:revisor/widget/cards/subject_card_v2.dart';

import 'provider/BaseProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  List<Widget> sList = [];

  @override
  void initState() {
    super.initState();
    HomePresenter presenter = HomePresenter(this);
    presenter.getSubjects(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(builder: (_, baseProvider, __) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(baseProvider.scaleFactor == 1 ? 0 : 23.0),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevButton(
                    width: 40.0,
                    height: 40.0,
                    radius: 8.0,
                    color: AppColors.colorPrimaryLightV2,
                    child: Center(
                      child: Image.asset(Images.kIconHamburger, width: 24, height: 24),
                    ),
                    onTap: () {
                      if (baseProvider.isOpen)
                        baseProvider.close();
                      else
                        baseProvider.open();
                    },
                  ),
                  Image.asset(Images.kAppLogo, height: 25.0),
                  RevButton(
                    width: 40.0,
                    color: AppColors.white,
                    text: "",
                  ),
                ],
              ),
            ),
            Image.asset(Images.kPlaceHolderBanner),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                text: TextSpan(
                  text: 'Choose What\n',
                  style: textStyleRegular18pxW600,
                  children: [
                    TextSpan(text: "To learn today?", style: textStyle14px300w),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [...sList],
                  ),
                ],
              ),
            ),
            verticalSpace(10.0),
          ],
        ),
      );
    });
  }

  @override
  onError(String message) {
    Utility.showToast(null, message);
  }

  @override
  void onSubjectFetched(HomeSubjectResponse response) {
    for (Subject res in response.data.jsonData.subject) {
      sList.add(SubjectCardV2(res));
    }
    setState(() {});
  }

  @override
  void onNoSubjectsFound(String message) {
    Utility.showErrorToast(context, message);
    Navigator.pushReplacementNamed(context, Screens.kSelectStream);
  }
}
