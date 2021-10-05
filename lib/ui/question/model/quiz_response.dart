/// message : "Successfully"
/// status : true
/// data : {"jsonData":[{"questionId":307,"questionType":1,"answerType":1,"conceptName":"1","conceptNumber":1,"questionNote":"Single select","image":null,"leftOption":null,"questionDescription":"You can use work around to solve your issue, simple set all the strings before you compare them to lower case\n\n ","answerOption":[{"answerId":1285,"answerOption":"1","position":null},{"answerId":1286,"answerOption":"2","position":null},{"answerId":1287,"answerOption":"3","position":null},{"answerId":1288,"answerOption":"correct","position":1},{"answerId":1289,"answerOption":"4","position":null},{"answerId":1290,"answerOption":"5","position":null}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":308,"questionType":1,"answerType":2,"conceptName":"12","conceptNumber":2,"questionNote":"): Correct: true","image":null,"leftOption":null,"questionDescription":"I/flutter (32123): Choose the correct option: consumer rebuild ","answerOption":[{"answerId":1291,"answerOption":"1","position":null},{"answerId":1292,"answerOption":"2","position":null},{"answerId":1293,"answerOption":"correct ","position":1},{"answerId":1294,"answerOption":"3","position":null},{"answerId":1295,"answerOption":"correct","position":1},{"answerId":1296,"answerOption":"correct","position":1}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":310,"questionType":6,"answerType":6,"conceptName":"1","conceptNumber":3,"questionNote":"give one word","image":null,"leftOption":null,"questionDescription":"I/flutter (32123): Question ID: 307 ","answerOption":[{"answerId":1298,"answerOption":"correct","position":1}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":311,"questionType":3,"answerType":7,"conceptName":"23","conceptNumber":4,"questionNote":"match","image":null,"leftOption":["1","2","3","4","5","6","7"],"questionDescription":"  verticalSpace(15.0),\n            Header(headerText: \"Question\", padding: EdgeInsets.symmetric(horizontal: 20.0)),\n            Padding(\n              padding: EdgeInsets.symmetric(horizontal: 20.0),\n              child: Column(\n                crossAxisAlignment: CrossAxisAlignment.start,\n                children: [\n                  verticalSpace(35.0),\n                  ClipRRect(\n                    borderRadius: BorderRadius.circular(8),\n                    child: Container(\n                      height: 10,\n                      child: LinearProgressIndicator(\n                        value: 0.60, // percent filled\n                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),\n                        backgroundColor: AppColors.colorPrimaryLightV2,\n                      ),\n                    ),\n                  ),\n                  verticalSpace(24.0),\n                  RichText(\n                    overflow: TextOverflow.ellipsis,\n                    maxLines: 7,\n                    text: TextSpan(\n                      text: 'Question 1',\n                      style: textStyleDark16px600w,\n                      children: [\n                        TextSpan(text: \"/10\", style: textStyleSubText12px600w),\n                      ],\n                    ),\n                  ),\n                  verticalSpace(10.0),\n                  Text('Note: Only one answer is correct per numbered item', style: textStyleSubText12px400w),\n                  verticalSpace(10.0),\n                  RichText(\n                    text: TextSpan(\n                      children: <InlineSpan>[\n                        ...blankExtractor(\"The ratio _ total deposits that a _ bank has to _ with _ is called:\")\n                      ],\n                    ),\n                    textAlign: TextAlign.start,\n                  )\n                ],\n              ),\n            ), ","answerOption":[{"answerId":1299,"answerOption":"1","position":0},{"answerId":1300,"answerOption":"2","position":1},{"answerId":1301,"answerOption":"3","position":2},{"answerId":1302,"answerOption":"4","position":3},{"answerId":1303,"answerOption":"5","position":4},{"answerId":1304,"answerOption":"6","position":5},{"answerId":1305,"answerOption":"7","position":6}],"giveReasonOption":null,"giveReasonCorrectOption":""}]}

class QuizResponse {
  int chapterId = 0;

  QuizResponse({
    String message,
    bool status,
    Data data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  QuizResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String _message;
  bool _status;
  Data _data;

  String get message => _message;

  bool get status => _status;

  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// jsonData : [{"questionId":307,"questionType":1,"answerType":1,"conceptName":"1","conceptNumber":1,"questionNote":"Single select","image":null,"leftOption":null,"questionDescription":"You can use work around to solve your issue, simple set all the strings before you compare them to lower case\n\n ","answerOption":[{"answerId":1285,"answerOption":"1","position":null},{"answerId":1286,"answerOption":"2","position":null},{"answerId":1287,"answerOption":"3","position":null},{"answerId":1288,"answerOption":"correct","position":1},{"answerId":1289,"answerOption":"4","position":null},{"answerId":1290,"answerOption":"5","position":null}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":308,"questionType":1,"answerType":2,"conceptName":"12","conceptNumber":2,"questionNote":"): Correct: true","image":null,"leftOption":null,"questionDescription":"I/flutter (32123): Choose the correct option: consumer rebuild ","answerOption":[{"answerId":1291,"answerOption":"1","position":null},{"answerId":1292,"answerOption":"2","position":null},{"answerId":1293,"answerOption":"correct ","position":1},{"answerId":1294,"answerOption":"3","position":null},{"answerId":1295,"answerOption":"correct","position":1},{"answerId":1296,"answerOption":"correct","position":1}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":310,"questionType":6,"answerType":6,"conceptName":"1","conceptNumber":3,"questionNote":"give one word","image":null,"leftOption":null,"questionDescription":"I/flutter (32123): Question ID: 307 ","answerOption":[{"answerId":1298,"answerOption":"correct","position":1}],"giveReasonOption":null,"giveReasonCorrectOption":""},{"questionId":311,"questionType":3,"answerType":7,"conceptName":"23","conceptNumber":4,"questionNote":"match","image":null,"leftOption":["1","2","3","4","5","6","7"],"questionDescription":"  verticalSpace(15.0),\n            Header(headerText: \"Question\", padding: EdgeInsets.symmetric(horizontal: 20.0)),\n            Padding(\n              padding: EdgeInsets.symmetric(horizontal: 20.0),\n              child: Column(\n                crossAxisAlignment: CrossAxisAlignment.start,\n                children: [\n                  verticalSpace(35.0),\n                  ClipRRect(\n                    borderRadius: BorderRadius.circular(8),\n                    child: Container(\n                      height: 10,\n                      child: LinearProgressIndicator(\n                        value: 0.60, // percent filled\n                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),\n                        backgroundColor: AppColors.colorPrimaryLightV2,\n                      ),\n                    ),\n                  ),\n                  verticalSpace(24.0),\n                  RichText(\n                    overflow: TextOverflow.ellipsis,\n                    maxLines: 7,\n                    text: TextSpan(\n                      text: 'Question 1',\n                      style: textStyleDark16px600w,\n                      children: [\n                        TextSpan(text: \"/10\", style: textStyleSubText12px600w),\n                      ],\n                    ),\n                  ),\n                  verticalSpace(10.0),\n                  Text('Note: Only one answer is correct per numbered item', style: textStyleSubText12px400w),\n                  verticalSpace(10.0),\n                  RichText(\n                    text: TextSpan(\n                      children: <InlineSpan>[\n                        ...blankExtractor(\"The ratio _ total deposits that a _ bank has to _ with _ is called:\")\n                      ],\n                    ),\n                    textAlign: TextAlign.start,\n                  )\n                ],\n              ),\n            ), ","answerOption":[{"answerId":1299,"answerOption":"1","position":0},{"answerId":1300,"answerOption":"2","position":1},{"answerId":1301,"answerOption":"3","position":2},{"answerId":1302,"answerOption":"4","position":3},{"answerId":1303,"answerOption":"5","position":4},{"answerId":1304,"answerOption":"6","position":5},{"answerId":1305,"answerOption":"7","position":6}],"giveReasonOption":null,"giveReasonCorrectOption":""}]

class Data {
  Data({
    List<JsonData> jsonData,
  }) {
    _jsonData = jsonData;
  }

  Data.fromJson(dynamic json) {
    if (json['jsonData'] != null) {
      _jsonData = [];
      json['jsonData'].forEach((v) {
        _jsonData.add(JsonData.fromJson(v));
      });
    }
  }

  List<JsonData> _jsonData;

  List<JsonData> get jsonData => _jsonData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_jsonData != null) {
      map['jsonData'] = _jsonData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// questionId : 307
/// questionType : 1
/// answerType : 1
/// conceptName : "1"
/// conceptNumber : 1
/// questionNote : "Single select"
/// image : null
/// leftOption : null
/// questionDescription : "You can use work around to solve your issue, simple set all the strings before you compare them to lower case\n\n "
/// answerOption : [{"answerId":1285,"answerOption":"1","position":null},{"answerId":1286,"answerOption":"2","position":null},{"answerId":1287,"answerOption":"3","position":null},{"answerId":1288,"answerOption":"correct","position":1},{"answerId":1289,"answerOption":"4","position":null},{"answerId":1290,"answerOption":"5","position":null}]
/// giveReasonOption : null
/// giveReasonCorrectOption : ""

class JsonData {
  JsonData({
    int questionId,
    int questionType,
    int answerType,
    String conceptName,
    int conceptNumber,
    String questionNote,
    dynamic image,
    dynamic leftOption,
    String questionDescription,
    List<AnswerOption> answerOption,
    dynamic giveReasonOption,
    String giveReasonCorrectOption,
  }) {
    _questionId = questionId;
    _questionType = questionType;
    _answerType = answerType;
    _conceptName = conceptName;
    _conceptNumber = conceptNumber;
    _questionNote = questionNote;
    _image = image;
    _leftOption = leftOption;
    _questionDescription = questionDescription;
    _answerOption = answerOption;
    _giveReasonOption = giveReasonOption;
    _giveReasonCorrectOption = giveReasonCorrectOption;
  }

  JsonData.fromJson(dynamic json) {
    _questionId = json['questionId'];
    _questionType = json['questionType'];
    _answerType = json['answerType'];
    _conceptName = json['conceptName'];
    _conceptNumber = json['conceptNumber'];
    _questionNote = json['questionNote'];
    _image = json['image'];
    _leftOption = json['leftOption'] as List<dynamic>;
    _questionDescription = json['questionDescription'];
    if (json['answerOption'] != null) {
      _answerOption = [];
      json['answerOption'].forEach((v) {
        _answerOption.add(AnswerOption.fromJson(v));
      });
    }
    _giveReasonOption = json['giveReasonOption'];
    _giveReasonCorrectOption = json['giveReasonCorrectOption'];
  }

  int _questionId;
  int _questionType;
  int _answerType;
  String _conceptName;
  num _conceptNumber;
  String _questionNote;
  dynamic _image;
  List<dynamic> _leftOption;
  String _questionDescription;
  List<AnswerOption> _answerOption;
  List<dynamic> _giveReasonOption;
  String _giveReasonCorrectOption;

  int get questionId => _questionId;

  int get questionType => _questionType;

  int get answerType => _answerType;

  String get conceptName => _conceptName;

  num get conceptNumber => _conceptNumber ?? 0;

  String get questionNote => _questionNote;

  dynamic get image => _image;

  List<dynamic> get leftOption => _leftOption;

  String get questionDescription => _questionDescription;

  List<AnswerOption> get answerOption => _answerOption;

  List<dynamic> get giveReasonOption => _giveReasonOption;

  String get giveReasonCorrectOption => _giveReasonCorrectOption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = _questionId;
    map['questionType'] = _questionType;
    map['answerType'] = _answerType;
    map['conceptName'] = _conceptName;
    map['conceptNumber'] = _conceptNumber;
    map['questionNote'] = _questionNote;
    map['image'] = _image;
    map['leftOption'] = _leftOption;
    map['questionDescription'] = _questionDescription;
    if (_answerOption != null) {
      map['answerOption'] = _answerOption.map((v) => v.toJson()).toList();
    }
    map['giveReasonOption'] = _giveReasonOption;
    map['giveReasonCorrectOption'] = _giveReasonCorrectOption;
    return map;
  }
}

/// answerId : 1285
/// answerOption : "1"
/// position : null

class AnswerOption {
  bool isSelected = false;

  AnswerOption({
    int answerId,
    String answerOption,
    dynamic position,
  }) {
    _answerId = answerId;
    _answerOption = answerOption;
    _position = position;
  }

  AnswerOption.fromJson(dynamic json) {
    _answerId = json['answerId'];
    _answerOption = json['answerOption'];
    _position = json['position'];
  }

  int _answerId;
  String _answerOption;
  dynamic _position;

  int get answerId => _answerId;

  String get answerOption => _answerOption;

  dynamic get position => _position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answerId'] = _answerId;
    map['answerOption'] = _answerOption;
    map['position'] = _position;
    return map;
  }
}
