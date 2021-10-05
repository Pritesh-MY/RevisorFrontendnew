import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/profile_edit/model/edit_profile_response.dart';

abstract class EditProfileView extends BaseView {
  void onProfileUpdated(EditProfileResponse response);
}
