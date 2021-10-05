import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/res/Strings.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/signup_request.dart';
import 'package:revisor/ui/socialLogin/social_login_presenter.dart';
import 'package:revisor/ui/socialLogin/social_login_view.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/user/CurrentUser.dart';
import 'package:revisor/user/user_type.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 21-04-2021.
class SignupScreen extends StatelessWidget implements SocialLoginView {
  FirebaseAuth _fireBaseAuth;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  BuildContext context;

  final GlobalKey<InputFieldState> nameGlobalKey = GlobalKey<InputFieldState>();
  final GlobalKey<InputFieldState> emailGlobalKey = GlobalKey<InputFieldState>();
  final GlobalKey<InputFieldState> passwordGlobalKey = GlobalKey<InputFieldState>();

  var _request = SignupRequest();

  @override
  Widget build(BuildContext context) {
    print("login rebuild");
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(Utility.screenHeight(context) * 0.020),
              Center(child: Text('Signup', style: textStyleRegular16px600px)),
              verticalSpace(Utility.screenHeight(context) * 0.030),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 190.0, height: 40.0)),
              verticalSpace(Utility.screenHeight(context) * 0.034),
              Text('Hello!', style: textStyleBlue24px600w),
              Text('Welcome to Revisor', style: textStyleBlue24px300w),
              verticalSpace(Utility.screenHeight(context) * 0.030),
              Row(
                children: [
                  Expanded(
                    child: RevButton(
                        onTap: () {
                          initializeGoogleSignin();
                        },
                        color: AppColors.inputFieldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Image.asset(Images.kGoogleImage),
                        )),
                  ),
                  horizontalSpace(15.0),
                  Expanded(
                    child: RevButton(
                        onTap: () {
                          initFacebookLogin();
                        },
                        color: AppColors.inputFieldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Image.asset(Images.kFacebookImage),
                        )),
                  ),
                ],
              ),
              verticalSpace(Utility.screenHeight(context) * 0.030),
              buildRow(),
              verticalSpace(Utility.screenHeight(context) * 0.030),
              InputField(
                leftIcon: Images.kIconPerson,
                placeHolderText: 'Name',
                errorMessage: 'Please enter name',
                onTextChange: (String val) => _request.firstName = val,
                key: nameGlobalKey,
              ),
              verticalSpace(Utility.screenHeight(context) * 0.020),
              InputField(
                leftIcon: Images.kIconEmail,
                placeHolderText: 'Email',
                errorMessage: 'Please enter email',
                onTextChange: (String val) => _request.username = val,
                key: emailGlobalKey,
              ),
              verticalSpace(Utility.screenHeight(context) * 0.020),
              InputField(
                leftIcon: Images.kIconLock,
                placeHolderText: 'Password',
                errorMessage: 'Please enter password',
                inputType: InputType.PASSWORD,
                onTextChange: (String val) => _request.password = val,
                isPassword: true,
                key: passwordGlobalKey,
              ),
              verticalSpace(Utility.screenHeight(context) * 0.020),
              RevButton(
                color: AppColors.colorPrimary,
                textStyle: textStyleWhiteRegular16px,
                text: kContinue,
                onTap: () => doSignup(context),
              ),
              verticalSpace(Utility.screenHeight(context) * 0.014),
              RevButton(
                height: 35.0,
                onTap: () => Navigator.pop(context),
                color: AppColors.white,
                text: "Sign in",
                textStyle: textStyleBlue14px600w,
              ),
              // By clicking on the “Continue” button, you agree to our Terms & Conditions
              RevButton(
                height: 35.0,
                onTap: () {},
                color: AppColors.white,
                child: Center(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By clicking on the',
                      style: textStyle12px500w,
                      children: [
                        TextSpan(text: " \"continue\" ", style: textStyleBlue12px600w),
                        TextSpan(text: "button, you agree to our", style: textStyle12px500w),
                        TextSpan(text: " Terms & Condition", style: textStyleBlue12px600w),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  initializeGoogleSignin() async {
    await AuthUser.getInstance().logout();
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _fireBaseAuth = FirebaseAuth.instanceFor(app: defaultApp);

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    String username = _googleSignIn.currentUser.displayName;
    var presenter = SocialLoginPresenter(this);
    presenter.socialLogin(context, googleAuth.accessToken, 1);

    /*final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userDetails = (await _fireBaseAuth.signInWithCredential(credential));
    userDetails.toString();*/
  }

  void initFacebookLogin() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var presenter = SocialLoginPresenter(this);
        presenter.socialLogin(context, result.accessToken.token, 2);
        // _presenter.socialLogin(result.accessToken.token, EndPoints.FACEBOOK, context);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }

  void doSignup(BuildContext context) {
    if (_request.firstName.isEmpty) {
      nameGlobalKey.currentState.showError();
    }

    if (_request.username.isEmpty) {
      emailGlobalKey.currentState.showError();
    }

    if (_request.password.isEmpty) {
      passwordGlobalKey.currentState.showError();
      return;
    }

    passwordGlobalKey.currentState.resetFocus();
    Navigator.pushNamed(context, Screens.kVerifyPhoneScreen, arguments: _request);
  }

  Row buildRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50.0,
            height: 1.5,
            color: AppColors.lineColorGrey,
          ),
          horizontalSpace(10.0),
          Text(
            kOr,
            style: textStyleBlue14px600w,
          ),
          horizontalSpace(10.0),
          Container(
            width: 50.0,
            height: 1.5,
            color: AppColors.lineColorGrey,
          ),
        ],
      );

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onSocialLoginSuccess(LoginResponse response) {
    var currentUser = CurrentUser()..userCredentials = response;
    AuthUser.getInstance().login(currentUser);
    var screen = response.data.jsonData.userState == UserType.NEW_USER ? Screens.kSelectStream : Screens.kBaseScreen;
    Navigator.popAndPushNamed(context, screen);
  }
}
