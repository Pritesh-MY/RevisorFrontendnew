/// message : "Successfully"
/// status : true
/// data : {"jsonData":{"userId":23,"firstName":"00","lastName":"32","username":"4512@example.com","picture":"","isExternalLogin":false,"countryCode":"+91","mobileNumber":"9988776655","stream":"","createdOn":"2021-09-08T07:57:37.2680078","modifiedOn":"2021-09-08T00:00:00"}}

class EditProfileResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  EditProfileResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  EditProfileResponse.fromJson(dynamic json) {
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

/// jsonData : {"userId":23,"firstName":"00","lastName":"32","username":"4512@example.com","picture":"","isExternalLogin":false,"countryCode":"+91","mobileNumber":"9988776655","stream":"","createdOn":"2021-09-08T07:57:37.2680078","modifiedOn":"2021-09-08T00:00:00"}

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

/// userId : 23
/// firstName : "00"
/// lastName : "32"
/// username : "4512@example.com"
/// picture : ""
/// isExternalLogin : false
/// countryCode : "+91"
/// mobileNumber : "9988776655"
/// stream : ""
/// createdOn : "2021-09-08T07:57:37.2680078"
/// modifiedOn : "2021-09-08T00:00:00"

class JsonData {
  int _userId;
  String _firstName;
  String _lastName;
  String _username;
  String _picture;
  bool _isExternalLogin;
  String _countryCode;
  String _mobileNumber;
  String _stream;
  String _createdOn;
  String _modifiedOn;

  int get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get username => _username;
  String get picture => _picture;
  bool get isExternalLogin => _isExternalLogin;
  String get countryCode => _countryCode;
  String get mobileNumber => _mobileNumber;
  String get stream => _stream;
  String get createdOn => _createdOn;
  String get modifiedOn => _modifiedOn;

  JsonData({
      int userId, 
      String firstName, 
      String lastName, 
      String username, 
      String picture, 
      bool isExternalLogin, 
      String countryCode, 
      String mobileNumber, 
      String stream, 
      String createdOn, 
      String modifiedOn}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _picture = picture;
    _isExternalLogin = isExternalLogin;
    _countryCode = countryCode;
    _mobileNumber = mobileNumber;
    _stream = stream;
    _createdOn = createdOn;
    _modifiedOn = modifiedOn;
}

  JsonData.fromJson(dynamic json) {
    _userId = json["userId"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _username = json["username"];
    _picture = json["picture"];
    _isExternalLogin = json["isExternalLogin"];
    _countryCode = json["countryCode"];
    _mobileNumber = json["mobileNumber"];
    _stream = json["stream"];
    _createdOn = json["createdOn"];
    _modifiedOn = json["modifiedOn"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["username"] = _username;
    map["picture"] = _picture;
    map["isExternalLogin"] = _isExternalLogin;
    map["countryCode"] = _countryCode;
    map["mobileNumber"] = _mobileNumber;
    map["stream"] = _stream;
    map["createdOn"] = _createdOn;
    map["modifiedOn"] = _modifiedOn;
    return map;
  }

}