import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/otp_sent_response.dart';
import 'package:revisor/ui/socialLogin/social_login_view.dart';

import 'model/resend_response.dart';

abstract class SignupView extends SocialLoginView {
  void onOtpSend(OtpSentResponse response);

  void onResent(ResendResponse response);

  void onUserVerified(LoginResponse response);
}
