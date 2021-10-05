import 'package:revisor/ui/base/base_view.dart';

import 'model/home_subject_response.dart';

abstract class HomeView extends BaseView {
  void onSubjectFetched(HomeSubjectResponse response);
  void onNoSubjectsFound(String message);
}
