import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/profile/model/profile_response.dart';

abstract class ProfileView extends BaseView {
  void onProfileInformationFetched(ProfileResponse response);

  void updateProfile();
}
