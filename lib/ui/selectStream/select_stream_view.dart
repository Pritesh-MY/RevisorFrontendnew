import 'package:revisor/ui/base/base_view.dart';
import 'package:revisor/ui/selectStream/model/stream_response.dart';
import 'package:revisor/ui/selectStream/model/user_stream_response.dart';

abstract class SelectStreamView extends BaseView {
  void onStreamsFetched(StreamResponse response);
  void onUserStreamUpdated(UserStreamResponse response);

}
