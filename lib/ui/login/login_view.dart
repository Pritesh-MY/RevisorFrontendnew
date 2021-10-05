import 'package:flutter/src/widgets/framework.dart';
import 'package:revisor/ui/login/model/login_response.dart';
import 'package:revisor/ui/socialLogin/social_login_view.dart';

abstract class LoginView extends SocialLoginView {
  void onLoginSuccess(LoginResponse response, BuildContext context);
}
