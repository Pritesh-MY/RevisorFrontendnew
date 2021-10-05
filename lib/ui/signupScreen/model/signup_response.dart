/// message : "Successfully Registered"
/// status : true
/// data : {"jsonData":{"otp":"1234","userId":16,"isVerified":false}}

class SignupResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  SignupResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  SignupResponse.fromJson(dynamic json) {
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

/// jsonData : {"otp":"1234","userId":16,"isVerified":false}

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

/// otp : "1234"
/// userId : 16
/// isVerified : false

class JsonData {
  String _otp;
  int _userId;
  bool _isVerified;

  String get otp => _otp;
  int get userId => _userId;
  bool get isVerified => _isVerified;

  JsonData({
      String otp, 
      int userId, 
      bool isVerified}){
    _otp = otp;
    _userId = userId;
    _isVerified = isVerified;
}

  JsonData.fromJson(dynamic json) {
    _otp = json["otp"];
    _userId = json["userId"];
    _isVerified = json["isVerified"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["otp"] = _otp;
    map["userId"] = _userId;
    map["isVerified"] = _isVerified;
    return map;
  }

}