import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/AppColors.dart';
import 'package:revisor/res/Fonts.dart';
import 'package:revisor/res/Images.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/selectStream/model/stream_response.dart';
import 'package:revisor/ui/selectStream/model/user_stream_response.dart';
import 'package:revisor/ui/selectStream/provider/subject_stream_provider.dart';
import 'package:revisor/ui/selectStream/select_stream_presenter.dart';
import 'package:revisor/ui/selectStream/select_stream_view.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/RevButton.dart';
import 'package:revisor/widget/cards/subject_card.dart';

class SelectStreamScreen extends StatefulWidget {
  const SelectStreamScreen({Key key}) : super(key: key);

  @override
  _SelectStreamScreenState createState() => _SelectStreamScreenState();
}

class _SelectStreamScreenState extends State<SelectStreamScreen> implements SelectStreamView {
  SelectStreamPresenter _presenter;
  var list = [];

  @override
  void initState() {
    super.initState();
    _presenter = SelectStreamPresenter(this);
    _presenter.getAllStreams(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.4),
              Center(child: Text('Select Stream', style: textStyleRegular16px600px)),
              verticalSpace(30.4),
              Align(alignment: Alignment.centerLeft, child: Image.asset(Images.kAppLogo, width: 132.0, height: 52.0)),
              verticalSpace(24.0),
              Text('Select', style: textStyleBlue24px600w),
              Text('Your stream', style: textStyleBlue24px300w),
              verticalSpace(30.0),
              Expanded(
                child: Consumer<SubjectStreamProvider>(
                  builder: (_, provider, __) {
                    return ListView(
                      clipBehavior: Clip.none,
                      children: [
                        Wrap(
                          clipBehavior: Clip.none,
                          spacing: 20.0,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            ...provider.streamList.map((e) => SubjectCard(model: e)).toList(),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
              Consumer<SubjectStreamProvider>(builder: (_, provider, __) {
                return RevButton(
                  color: provider.currentSelection == null ? AppColors.lineColorGrey : AppColors.colorPrimary,
                  onTap: () {
                    if (provider.currentSelection != null) _presenter.putStream(context, provider.currentSelection);
                  },
                  text: "CONTINUE",
                  textStyle: textStyleWhite16px600w,
                );
              }),
              verticalSpace(20.0)
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToast(context, message);
  }

  @override
  void onStreamsFetched(StreamResponse response) {
    var addressProvider = Provider.of<SubjectStreamProvider>(context, listen: false);
    for (var address in response.data.jsonData) {
      addressProvider.addAddress(address);
    }
  }

  @override
  void onUserStreamUpdated(UserStreamResponse response) {
    Navigator.of(context).pushNamedAndRemoveUntil(Screens.kBaseScreen, ModalRoute.withName('/'));
  }
}
