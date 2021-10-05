import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/res/Strings.dart';
import 'package:revisor/ui/login/login_presenter.dart';
import 'package:revisor/ui/login/login_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/socialLogin/social_login_presenter.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/user/CurrentUser.dart';
import 'package:revisor/user/user_type.dart';
import 'package:revisor/widget/InputField.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';

/// Created by Pratik Kataria on 21-04-2021.
class LoginScreen extends StatelessWidget implements LoginView {
  final GlobalKey<InputFieldState> emailGlobalKey = GlobalKey<InputFieldState>();
  BuildContext context;
  FirebaseAuth _fireBaseAuth;
  final GlobalKey<InputFieldState> passwordGlobalKey = GlobalKey<InputFieldState>();
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  var _email = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              verticalSpace(Utility.screenHeight(context) * 0.020),
              Center(child: Text('Login', style: textStyleRegular16px600px)),
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
                placeHolderText: 'Phone/Email',
                errorMessage: 'Please enter phone',
                onTextChange: (String val) => _email = val,
                key: emailGlobalKey,
              ),
              verticalSpace(Utility.screenHeight(context) * 0.020),
              InputField(
                leftIcon: Images.kIconLock,
                placeHolderText: 'Password',
                errorMessage: 'Please enter password',
                isPassword: true,
                onTextChange: (String val) => _password = val,
                key: passwordGlobalKey,
              ),
              verticalSpace(Utility.screenHeight(context) * 0.020),
              RevButton(
                color: AppColors.colorPrimary,
                textStyle: textStyleWhiteRegular16px,
                text: kContinue,
                onTap: () => doLogin(context),
              ),
              verticalSpace(12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevButton(
                    height: 35.0,
                    onTap: () => Navigator.pushNamed(context, Screens.kSignupScreen),
                    color: AppColors.white,
                    text: "Sign up",
                    textStyle: textStyleBlue14px600w,
                  ),
                  RevButton(
                    height: 35.0,
                    onTap: () => Navigator.pushNamed(context, Screens.kForgotPasswordPhoneNumberScreen),
                    color: AppColors.white,
                    text: "Forgot your password ?",
                    textStyle: textStyleBlue14px600w,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  initializeGoogleSignin() async {
    // await AuthUser.getInstance().logout();
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _fireBaseAuth = FirebaseAuth.instanceFor(app: defaultApp);

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    String username = _googleSignIn.currentUser.displayName;
    print(googleAuth.accessToken);
    var presenter = SocialLoginPresenter(this);
    presenter.socialLogin(context, googleAuth.accessToken, 1);
    // _presenter.socialLogin(googleAuth.accessToken, EndPoints.GMAIL, context, name: username ?? "");

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

    print("Facebook Token" + result.accessToken.token);
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

  void doLogin(BuildContext context) {
    if (_email.isEmpty) {
      emailGlobalKey.currentState.showError();
    }

    if (_password.isEmpty) {
      passwordGlobalKey.currentState.showError();
      return;
    }

    passwordGlobalKey.currentState.resetFocus();
    var _presenter = LoginPresenter(this);
    _presenter.doLogin(context, _email, _password);
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
  void onLoginSuccess(LoginResponse response, BuildContext context) {
    var currentUser = CurrentUser()..userCredentials = response;
    AuthUser.getInstance().login(currentUser);
    Navigator.popAndPushNamed(context, Screens.kBaseScreen);
  }

  @override
  void onSocialLoginSuccess(LoginResponse response) {
    var currentUser = CurrentUser()..userCredentials = response;
    AuthUser.getInstance().login(currentUser);
    var screen = response.data.jsonData.userState == UserType.NEW_USER ? Screens.kSelectStream : Screens.kBaseScreen;
    Navigator.popAndPushNamed(context, screen);
  }
}
