/// message : "Successfully logged in"
/// status : true
/// data : {"jsonData":{"userId":3,"firstName":"Pratik","lastName":"Kataria","username":"pratikkatariya3.pk@gmail.com","jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIzIiwibmJmIjoxNjMwNDkyMDkyLCJleHAiOjE2MzEwOTY4OTIsImlhdCI6MTYzMDQ5MjA5Mn0.vKlj3Dx6UtZQHaJyEjkgOV3s2XiYRmterXqWtOSb8HM","isVerified":true,"userState":2}}

class LoginResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  LoginResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
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

/// jsonData : {"userId":3,"firstName":"Pratik","lastName":"Kataria","username":"pratikkatariya3.pk@gmail.com","jwtToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIzIiwibmJmIjoxNjMwNDkyMDkyLCJleHAiOjE2MzEwOTY4OTIsImlhdCI6MTYzMDQ5MjA5Mn0.vKlj3Dx6UtZQHaJyEjkgOV3s2XiYRmterXqWtOSb8HM","isVerified":true,"userState":2}

class Data {
  JsonData _jsonData;

  JsonData get jsonData => _jsonData;


  set jsonData(JsonData value) {
    _jsonData = value;
  }

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

/// userId : 3
/// firstName : "Pratik"
/// lastName : "Kataria"
/// username : "pratikkatariya3.pk@gmail.com"
/// jwtToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIzIiwibmJmIjoxNjMwNDkyMDkyLCJleHAiOjE2MzEwOTY4OTIsImlhdCI6MTYzMDQ5MjA5Mn0.vKlj3Dx6UtZQHaJyEjkgOV3s2XiYRmterXqWtOSb8HM"
/// isVerified : true
/// userState : 2

class JsonData {
  int _userId;
  String _firstName;
  String _lastName;
  String _username;
  String _jwtToken;
  bool _isVerified;
  int _userState;

  int get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get username => _username;
  String get jwtToken => _jwtToken;
  bool get isVerified => _isVerified;
  int get userState => _userState;


  set userId(int value) {
    _userId = value;
  }

  JsonData({
      int userId, 
      String firstName, 
      String lastName, 
      String username, 
      String jwtToken, 
      bool isVerified, 
      int userState}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _jwtToken = jwtToken;
    _isVerified = isVerified;
    _userState = userState;
}

  JsonData.fromJson(dynamic json) {
    _userId = json["userId"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _username = json["username"];
    _jwtToken = json["jwtToken"];
    _isVerified = json["isVerified"];
    _userState = json["userState"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["username"] = _username;
    map["jwtToken"] = _jwtToken;
    map["isVerified"] = _isVerified;
    map["userState"] = _userState;
    return map;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set username(String value) {
    _username = value;
  }

  set jwtToken(String value) {
    _jwtToken = value;
  }

  set isVerified(bool value) {
    _isVerified = value;
  }

  set userState(int value) {
    _userState = value;
  }
}