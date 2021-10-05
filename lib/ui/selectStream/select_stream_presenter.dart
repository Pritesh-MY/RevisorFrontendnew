import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:revisor/api/ApiController.dart';
import 'package:revisor/api/EndPoint.dart';
import 'package:revisor/ui/selectStream/model/stream_response.dart' as sr;
import 'package:revisor/ui/selectStream/model/user_stream_response.dart';
import 'package:revisor/ui/selectStream/select_stream_view.dart';
import 'package:revisor/user/AuthUser.dart';
import 'package:revisor/utils/Dialogs.dart';
import 'package:revisor/utils/NetworkCheck.dart';
import 'package:revisor/utils/Utility.dart';

/// Created by Pratik Kataria on 19-05-2021.

class SelectStreamPresenter {
  var tag = 'SelectStreamPresenter';

  SelectStreamView _view;
  ApiController _repository = ApiController.getInstance();

  SelectStreamPresenter(this._view);

  getAllStreams(BuildContext context) async {
    if (await NetworkCheck.check()) {
      Dialogs.showLoader(context, 'Getting streams ...', '');
      _repository.get(EndPoints.GET_ALL_STREAMS, headers: await Utility.header())
        ..then((Response res) async {
          Dialogs.hideLoader(context);
          sr.StreamResponse response = sr.StreamResponse.fromJson(res.data);
          _view.onStreamsFetched(response);
        }).catchError((e) {
          Dialogs.hideLoader(context);
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }

  putStream(BuildContext context, sr.JsonData data) async {
    if (await NetworkCheck.check()) {
      var userId = (await AuthUser.getInstance().getCurrentUser())?.userCredentials?.data?.jsonData?.userId ?? -1;

      var body = {
        "userId": userId,
        "stream": {
          "streamId": data.streamId,
          "streamName": data.streamName,
          "image": data.image,
        }
      };

      Dialogs.showLoader(context, 'Updating your stream ...', '');
      _repository.patch(EndPoints.PUT_SELECTED_STREAM, body: body, headers: await Utility.header())
        ..then((Response res) async {
          Utility.log(tag, res.data);
          Dialogs.hideLoader(context);
          UserStreamResponse response = UserStreamResponse.fromJson(res.data);
          _view.onUserStreamUpdated(response);
        }).catchError((e) {
          Utility.log(tag, e);
          Dialogs.hideLoader(context);
          // DioErrorParser.parseError(e, _signupView);
        });
    }
  }
}
