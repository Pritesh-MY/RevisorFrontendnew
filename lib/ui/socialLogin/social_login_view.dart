import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';

abstract class SocialLoginView extends BaseView {
  void onSocialLoginSuccess(LoginResponse response);
}
