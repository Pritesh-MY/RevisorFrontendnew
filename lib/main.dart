import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/changePassword/change_password_screen.dart';
import 'package:revisor/ui/forgotPassword/forgot_password_otp_screen.dart';
import 'package:revisor/ui/forgotPassword/reset_password_changed_successfully_screen.dart';
import 'package:revisor/ui/forgotPassword/reset_password_screen.dart';
import 'package:revisor/ui/home/drawer/rev_drawer.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/ui/login/login_screen.dart';
import 'package:revisor/ui/onboaring/onboarding.dart';
import 'package:revisor/ui/profile/profile_screen.dart';
import 'package:revisor/ui/profile_edit/edit_profile_screen.dart';
import 'package:revisor/ui/question/drag_drop_question_screen.dart';
import 'package:revisor/ui/question/fill_in_the_blanks_question_screen.dart';
import 'package:revisor/ui/question/match_the_following_screen.dart';
import 'package:revisor/ui/question/one_word_screen.dart';
import 'package:revisor/ui/quiz/provider/quiz_provider.dart';
import 'package:revisor/ui/quiz/quiz_screen.dart';
import 'package:revisor/ui/report/report_screen.dart';
import 'package:revisor/ui/report/report_screen_v2.dart';
import 'package:revisor/ui/report/report_screen_v3.dart';
import 'package:revisor/ui/selectChapter/select_chapter_screen.dart';
import 'package:revisor/ui/selectStream/select_stream_screen.dart';
import 'package:revisor/ui/signupScreen/signup_screen.dart';
import 'package:revisor/ui/storyScreen/story_screen.dart';

import 'res/AppColors.dart';
import 'res/RouteTransition.dart';
import 'ui/forgotPassword/forgot_password_phone_number_screen.dart';
import 'ui/phoneNumber/phone_number_screen.dart';
import 'ui/question/provider/drag_drop_question_provider.dart';
import 'ui/selectStream/provider/subject_stream_provider.dart';
import 'ui/verifyOtp/verfiy_otp_phone_number.dart';
import 'user/AuthUser.dart';
import 'utils/Utility.dart';
import 'utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Utility.statusBarAndNavigationBarColor();
  // await Firebase.initializeApp();
  Utility.portrait();

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();

  Future.delayed(Duration(seconds: 2)).whenComplete(() => {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]).then((value) => runApp(MyApp(isLoggedIn: authResult)))
      });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Revisor',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        theme: ThemeData(primarySwatch: Colors.amber, scaffoldBackgroundColor: AppColors.white),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return RouteTransition(widget: OnboardingScreen());
              break;
            case Screens.kStoryScreen:
              return RouteTransition(widget: StoryScreen());
              break;
            case Screens.kOnboardingScreen:
              return RouteTransition(widget: OnboardingScreen());
              break;
            case Screens.kSignupScreen:
              return RouteTransition(widget: SignupScreen());
              break;
            case Screens.kLoginScreen:
              return RouteTransition(widget: LoginScreen());
              break;
            case Screens.kVerifyPhoneScreen:
              return RouteTransition(widget: PhoneNumberScreen(settings.arguments));
              break;
            case Screens.kVerifyOtpScreen:
              return RouteTransition(widget: VerifyOtpPhoneNumber(settings.arguments));
              break;
            case Screens.kForgotPasswordPhoneNumberScreen:
              return RouteTransition(widget: ForgotPasswordPhoneNumberScreen());
              break;
            case Screens.kForgotPasswordOtpScreen:
              return RouteTransition(widget: ForgotPasswordOtpScreen(settings.arguments));
              break;
            case Screens.kResetPasswordChangedSuccessfullyScreen:
              return RouteTransition(widget: ResetPasswordChangedSuccessfullyScreen());
              break;
            case Screens.kResetPasswordScreen:
              return RouteTransition(widget: ResetPasswordScreen(settings.arguments));
              break;
            case Screens.kSelectStream:
              return RouteTransition(
                widget: ChangeNotifierProvider<SubjectStreamProvider>(
                  create: (context) => SubjectStreamProvider(),
                  child: SelectStreamScreen(),
                ),
              );
              break;
            case Screens.kBaseScreen:
              return RouteTransition(
                widget: ChangeNotifierProvider<BaseProvider>(
                  create: (context) => BaseProvider(),
                  child: RevDrawer(),
                ),
              );
              break;
            case Screens.kProfileScreen:
              return RouteTransition(widget: ProfileScreen());
              break;
            case Screens.kEditProfileScreen:
              return RouteTransition(widget: EditProfileScreen());
              break;
            case Screens.kChangePasswordScreen:
              return RouteTransition(widget: ChangePasswordScreen());
              break;
            case Screens.kReportScreen:
              return RouteTransition(widget: ReportScreen());
              break;
            case Screens.kReportV2Screen:
              return RouteTransition(widget: ReportScreenV2());
              break;
            case Screens.kReportV3Screen:
              return RouteTransition(widget: ReportScreenV3());
              break;
            case Screens.kChapterScreen:
              return RouteTransition(widget: SelectChapterScreen(settings.arguments));
              break;
            case Screens.kFillInTheBlanksScreen:
              return RouteTransition(widget: FillInTheBlanks());
              break;
            case Screens.kOneWordScreen:
              return RouteTransition(widget: OneWordQuestionScreen());
              break;
            case Screens.kMatchTheFollowingQuestions:
              return RouteTransition(widget: MatchTheFollowingQuestionScreen());
              break;
            case Screens.kQuizScreen:
              return RouteTransition(
                widget: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<QuizProvider>(create: (_) => QuizProvider()),
                    ChangeNotifierProvider<DragDropQuestionProvider>(create: (context) => DragDropQuestionProvider())
                  ],
                  child: QuizScreen(settings.arguments),
                ),
              );
              break;
            case Screens.kDragAndDropQuestionScreen:
              return RouteTransition(
                widget: ChangeNotifierProvider<DragDropQuestionProvider>(
                  create: (context) => DragDropQuestionProvider(),
                  child: DragAndDropQuestionScreen(),
                ),
              );
              break;
            default:
              return RouteTransition(widget: StoryScreen());
          }
        },
        home: /*AssertionAndReasoningScreen()*/ checkAuthUser(isLoggedIn));
  }

  checkAuthUser(isLoggedIn) {
    if (isLoggedIn) {
      return ChangeNotifierProvider<BaseProvider>(
        create: (context) => BaseProvider(),
        child: RevDrawer(),
      );
    } else {
      return StoryScreen();
    }
  }
}

/*
ChangeNotifierProvider<SubjectStreamProvider>(
        create: (context) => SubjectStreamProvider(),
        child: SelectStreamScreen(),
      )
*/

/*

ChangeNotifierProvider<DragDropQuestionProvider>(
        create: (context) => DragDropQuestionProvider(),
        child: ImageBasedFillInTheBlanksQuestion(),
      )

ChooseTheCorrectOptionImageBased()
*/
