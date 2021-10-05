import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/login/model/login_response.dart' as CurrentUser;
import 'package:revisor/ui/profile_edit/edit_profile_presenter.dart';
import 'package:revisor/ui/profile_edit/edit_profile_view.dart';
import 'package:revisor/ui/profile_edit/model/edit_profile_request.dart';
import 'package:revisor/ui/profile_edit/model/edit_profile_response.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/widget/InputField2.dart';
import 'package:revisor/widget/RevButton.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> implements EditProfileView {
  final GlobalKey<InputFieldState> nameGlobalKey = GlobalKey<InputFieldState>();
  CurrentUser.JsonData currentUserData;
  EditProfileRequest updateUserDataRequest;
  EditProfilePresenter presenter;

  @override
  void initState() {
    super.initState();

    presenter = EditProfilePresenter(this);
    initAsync();
  }

  initAsync() async {
    currentUserData = (await AuthUser.getInstance().getCurrentUser()).userCredentials.data.jsonData;
    updateUserDataRequest = EditProfileRequest()
      ..firstName = currentUserData.firstName
      ..username = currentUserData.username
      ..lastName = currentUserData.lastName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(
                headerText: "Edit Profile",
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
                  onTap: () {},
                ),
              ),
              verticalSpace(35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RevButton(
                    width: 40.0,
                    height: 40.0,
                    color: AppColors.inputFieldBackgroundColor,
                    radius: 8.0,
                    child: Center(
                      child: Image.asset(
                        Images.kIconPen,
                        width: 21,
                        height: 21,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Image.asset(Images.kPlaceHolderO6, width: 90.0, height: 90.0),
                  RevButton(
                    width: 40.0,
                    height: 40.0,
                    color: AppColors.inputFieldBackgroundColor,
                    radius: 8.0,
                    child: Center(
                      child: Image.asset(
                        Images.kIconBin,
                        width: 17,
                        height: 17,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              verticalSpace(20.0),
              InputField(
                leftIcon: Images.kIconPerson,
                placeHolderText: '${currentUserData?.firstName ?? ""}',
                errorMessage: 'Please enter phone',
                onTextChange: (String val) {
                  updateUserDataRequest.firstName = val;
                },
                key: nameGlobalKey,
              ),
              verticalSpace(20.0),
              Stack(alignment: Alignment.center, children: [
                InputField(
                  leftIcon: Images.kIconEmail,
                  placeHolderText: '${currentUserData?.username ?? ""}',
                  errorMessage: 'Please enter phone',
                  onTextChange: (String val) => {
                    updateUserDataRequest.username = val,
                  },
                ),
                Positioned(right: 20, child: Text('Verify', style: textStyleRed12px500w))
              ]),
              verticalSpace(20.0),
              Stack(alignment: Alignment.center, children: [
                InputField2(
                  leftIcon: Images.kIconPhone,
                  placeHolderText: '${"NA"}',
                  errorMessage: 'Please enter phone',
                  onTextChange: (String val) => {
                    updateUserDataRequest.firstName = val,
                  },
                ),
                Positioned(right: 20, child: Text('Verified', style: textStyleGreen12px500w))
              ]),
              verticalSpace(20.0),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, Screens.kChangePasswordScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: Utility.screenWidth(context),
                  height: 52.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.black)),
                  child: Row(
                    children: [
                      Image.asset(Images.kIconLock, width: 20, height: 20),
                      horizontalSpace(20.0),
                      Expanded(child: Text('••••••••', style: textStyleDarkRegular18pxW700)),
                      Image.asset(Images.kIconCircleRightArrow, width: 20, height: 20),
                    ],
                  ),
                ),
              ),
              verticalSpace(20.0),
              RevButton(
                text: "UPDATE",
                textStyle: textStyleWhite14px600w,
                onTap: () {
                  presenter.updateProfile(context, currentUserData.userId, updateUserDataRequest);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onProfileUpdated(EditProfileResponse response) async {
    currentUserData.firstName = response.data.jsonData.firstName;
    currentUserData.username = response.data.jsonData.username;

    var user = await AuthUser.getInstance().getCurrentUser();
    user.userCredentials.data.jsonData = currentUserData;

    await AuthUser.getInstance().updateUser(user);
    Navigator.pop(context, true);
  }
}
