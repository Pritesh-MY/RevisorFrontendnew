/// message : "Success"
/// status : true
/// data : {"jsonData":{"otp":"6385","userId":0}}

class OtpSentResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  OtpSentResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  OtpSentResponse.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// jsonData : {"otp":"6385","userId":0}

class Data {
  JsonData _jsonData;

  JsonData get jsonData => _jsonData;

  Data({
      JsonData jsonData}){
    _jsonData = jsonData;
}

  Data.fromJson(dynamic json) {
    _jsonData = json["jsonData"] != null ? JsonData.fromJson(json["jsonData"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_jsonData != null) {
      map["jsonData"] = _jsonData.toJson();
    }
    return map;
  }

}

/// otp : "6385"
/// userId : 0

class JsonData {
  String _otp;
  int _userId;

  String get otp => _otp;
  int get userId => _userId;

  JsonData({
      String otp, 
      int userId}){
    _otp = otp;
    _userId = userId;
}

  JsonData.fromJson(dynamic json) {
    _otp = json["otp"];
    _userId = json["userId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["otp"] = _otp;
    map["userId"] = _userId;
    return map;
  }

}