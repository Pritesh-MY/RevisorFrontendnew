import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/question/model/quiz_response.dart';

import 'model/ChapterResponse.dart';

abstract class ChapterView extends BaseView {
  void onChaptersFetched(ChapterResponse response);

  void onQuizFetched(QuizResponse quizResponse);
}
