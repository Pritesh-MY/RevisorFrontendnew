import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/login/model/login_response.dart';

abstract class ChangePasswordView extends BaseView {
  void onPasswordChangedSuccessfully(LoginResponse response);
}
