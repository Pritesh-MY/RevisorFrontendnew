import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/signupScreen/model/resend_response.dart';

abstract class ForgotPasswordView extends BaseView {
  void onOtpSent(ResendResponse response);
  void onOtpVerified(LoginResponse response);
  void onPasswordChangedSuccessfully(LoginResponse response);
}
