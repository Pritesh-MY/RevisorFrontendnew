/// message : "Successfully"
/// status : true
/// data : {"jsonData":{"subjectId":30,"subjectName":"Economics","chapters":[{"chapterId":58,"chapterName":"Money","image":null},{"chapterId":59,"chapterName":"Barter System","image":null}]}}

class ChapterResponse {
  ChapterResponse({
      String message, 
      bool status, 
      Data data,}){
    _message = message;
    _status = status;
    _data = data;
}

  ChapterResponse.fromJson(dynamic json) {
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

/// jsonData : {"subjectId":30,"subjectName":"Economics","chapters":[{"chapterId":58,"chapterName":"Money","image":null},{"chapterId":59,"chapterName":"Barter System","image":null}]}

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

/// subjectId : 30
/// subjectName : "Economics"
/// chapters : [{"chapterId":58,"chapterName":"Money","image":null},{"chapterId":59,"chapterName":"Barter System","image":null}]

class JsonData {
  JsonData({
      int subjectId, 
      String subjectName, 
      List<Chapters> chapters,}){
    _subjectId = subjectId;
    _subjectName = subjectName;
    _chapters = chapters;
}

  JsonData.fromJson(dynamic json) {
    _subjectId = json['subjectId'];
    _subjectName = json['subjectName'];
    if (json['chapters'] != null) {
      _chapters = [];
      json['chapters'].forEach((v) {
        _chapters.add(Chapters.fromJson(v));
      });
    }
  }
  int _subjectId;
  String _subjectName;
  List<Chapters> _chapters;

  int get subjectId => _subjectId;
  String get subjectName => _subjectName;
  List<Chapters> get chapters => _chapters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectId'] = _subjectId;
    map['subjectName'] = _subjectName;
    if (_chapters != null) {
      map['chapters'] = _chapters.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// chapterId : 58
/// chapterName : "Money"
/// image : null

class Chapters {
  Chapters({
      int chapterId, 
      String chapterName, 
      dynamic image,}){
    _chapterId = chapterId;
    _chapterName = chapterName;
    _image = image;
}

  Chapters.fromJson(dynamic json) {
    _chapterId = json['chapterId'];
    _chapterName = json['chapterName'];
    _image = json['image'];
  }
  int _chapterId;
  String _chapterName;
  dynamic _image;

  int get chapterId => _chapterId;
  String get chapterName => _chapterName;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chapterId'] = _chapterId;
    map['chapterName'] = _chapterName;
    map['image'] = _image;
    return map;
  }

}