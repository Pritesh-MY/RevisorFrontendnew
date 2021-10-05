/// message : "Successfully added"
/// status : true
/// data : {"jsonData":null}

class QuizAnswerResponse {
  QuizAnswerResponse({
      String message, 
      bool status, 
      Data data,}){
    _message = message;
    _status = status;
    _data = data;
}

  QuizAnswerResponse.fromJson(dynamic json) {
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

/// jsonData : null

class Data {
  Data({
      dynamic jsonData,}){
    _jsonData = jsonData;
}

  Data.fromJson(dynamic json) {
    _jsonData = json['jsonData'];
  }
  dynamic _jsonData;

  dynamic get jsonData => _jsonData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonData'] = _jsonData;
    return map;
  }

}