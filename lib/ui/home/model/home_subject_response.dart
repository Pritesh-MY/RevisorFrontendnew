/// message : "Successfully"
/// status : true
/// data : {"jsonData":{"streamId":54,"banner":"wwwroot/assets/Banner.jpg","subject":[{"subjectId":30,"subjectName":"Economics","image":""}]}}

class HomeSubjectResponse {
  HomeSubjectResponse({
      String message, 
      bool status, 
      Data data,}){
    _message = message;
    _status = status;
    _data = data;
}

  HomeSubjectResponse.fromJson(dynamic json) {
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

/// jsonData : {"streamId":54,"banner":"wwwroot/assets/Banner.jpg","subject":[{"subjectId":30,"subjectName":"Economics","image":""}]}

class Data {
  Data({
      JsonData jsonData,}){
    _jsonData = jsonData;
}

  Data.fromJson(dynamic json) {
    _jsonData = json['jsonData'] != null ? JsonData.fromJson(json['jsonData']) : null;
  }
  JsonData _jsonData;

  JsonData get jsonData => _jsonData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_jsonData != null) {
      map['jsonData'] = _jsonData.toJson();
    }
    return map;
  }

}

/// streamId : 54
/// banner : "wwwroot/assets/Banner.jpg"
/// subject : [{"subjectId":30,"subjectName":"Economics","image":""}]

class JsonData {
  JsonData({
      int streamId, 
      String banner, 
      List<Subject> subject,}){
    _streamId = streamId;
    _banner = banner;
    _subject = subject;
}

  JsonData.fromJson(dynamic json) {
    _streamId = json['streamId'];
    _banner = json['banner'];
    if (json['subject'] != null) {
      _subject = [];
      json['subject'].forEach((v) {
        _subject.add(Subject.fromJson(v));
      });
    }
  }
  int _streamId;
  String _banner;
  List<Subject> _subject;

  int get streamId => _streamId;
  String get banner => _banner;
  List<Subject> get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['streamId'] = _streamId;
    map['banner'] = _banner;
    if (_subject != null) {
      map['subject'] = _subject.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// subjectId : 30
/// subjectName : "Economics"
/// image : ""

class Subject {
  Subject({
      int subjectId, 
      String subjectName, 
      String image,}){
    _subjectId = subjectId;
    _subjectName = subjectName;
    _image = image;
}

  Subject.fromJson(dynamic json) {
    _subjectId = json['subjectId'];
    _subjectName = json['subjectName'];
    _image = json['image'];
  }
  int _subjectId;
  String _subjectName;
  String _image;

  int get subjectId => _subjectId;
  String get subjectName => _subjectName;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectId'] = _subjectId;
    map['subjectName'] = _subjectName;
    map['image'] = _image;
    return map;
  }
}