import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/ui/profile/model/profile_response.dart';
import 'package:revisor/ui/profile/profile_presenter.dart';
import 'package:revisor/ui/profile/profile_view.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/RevButton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements ProfileView {
  JsonData profileDetails;
  ProfilePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = ProfilePresenter(this);
    presenter.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(
                headerText: "Profile",
                onBackPressed: () {
                  var provider = Provider.of<BaseProvider>(context, listen: false);
                  provider.currentScreen = Screens.kHomeScreen;
                },
                rightWidget: RevButton(
                  width: 40.0,
                  height: 40.0,
                  color: AppColors.inputFieldBackgroundColor,
                  radius: 8.0,
                  child: Center(
                    child: Image.asset(
                      Images.kIconPen,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onTap: () async {
                    var update = await Navigator.pushNamed(context, Screens.kEditProfileScreen);
                    if (update is bool) updateProfile();
                  },
                ),
              ),
              verticalSpace(35.0),
              Row(
                children: [
                  Image.asset(Images.kPlaceHolderO6, width: 90.0, height: 90.0),
                  horizontalSpace(20.0),
                  Text('${profileDetails?.firstName ?? "NA"}', style: textStyleDarkHeavy24px600),
                ],
              ),
              verticalSpace(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('2', style: textStyleRegular18pxW600),
                      Text('Chapter completed', style: textStyleSubText12px400w),
                    ],
                  ),
                  Column(
                    children: [
                      Text('10/23', style: textStyleRegular18pxW600),
                      Text('Invites accepted', style: textStyleSubText12px400w),
                    ],
                  ),
                ],
              ),
              verticalSpace(20.0),
              Container(height: 2, color: AppColors.inputFieldBackgroundColor),
              verticalSpace(20.0),
              Text('Contact information', style: textStyleRegular18pxW600),
              verticalSpace(20.0),
              Row(
                children: [
                  Image.asset(Images.kIconEmail, height: 24.0),
                  horizontalSpace(12.0),
                  Text('${profileDetails?.username ?? "NA"}', style: textStyleDark14px500w),
                ],
              ),
              verticalSpace(20.0),
              if (!(profileDetails?.isExternalLogin ?? false))
                Row(
                  children: [
                    Image.asset(Images.kIconPhone, height: 24.0),
                    horizontalSpace(12.0),
                    Text('${profileDetails?.mobileNumber ?? "NA"}', style: textStyleDark14px500w),
                  ],
                ),
              verticalSpace(20.0),
              Container(height: 2, color: AppColors.inputFieldBackgroundColor),
              verticalSpace(20.0),
              // Text('Friends on Revisor', style: textStyleRegular18pxW600),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showToast(context, message);
  }

  @override
  void onProfileInformationFetched(ProfileResponse response) {
    profileDetails = response.data.jsonData;
    setState(() {});
  }

  @override
  void updateProfile() {
    presenter.getProfile(context);
  }
}
