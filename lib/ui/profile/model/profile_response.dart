/// message : "Successfully"
/// status : true
/// data : {"jsonData":{"userId":3,"firstName":"Pratik","lastName":"Kataria","username":"pratikkatariya3.pk@gmail.com","picture":"https://lh3.googleusercontent.com/a-/AOh14GjnUOKFKeKMW9N7MveQr_09I_x2ZmOAquemOcAnNA=s96-c","isVerified":true,"isExternalLogin":true,"countryCode":"","mobileNumber":"","stream":{"streamId":1,"streamName":"Science","image":""},"createdOn":"","modifiedOn":""}}

class ProfileResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  ProfileResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  ProfileResponse.fromJson(dynamic json) {
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

/// jsonData : {"userId":3,"firstName":"Pratik","lastName":"Kataria","username":"pratikkatariya3.pk@gmail.com","picture":"https://lh3.googleusercontent.com/a-/AOh14GjnUOKFKeKMW9N7MveQr_09I_x2ZmOAquemOcAnNA=s96-c","isVerified":true,"isExternalLogin":true,"countryCode":"","mobileNumber":"","stream":{"streamId":1,"streamName":"Science","image":""},"createdOn":"","modifiedOn":""}

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

/// userId : 3
/// firstName : "Pratik"
/// lastName : "Kataria"
/// username : "pratikkatariya3.pk@gmail.com"
/// picture : "https://lh3.googleusercontent.com/a-/AOh14GjnUOKFKeKMW9N7MveQr_09I_x2ZmOAquemOcAnNA=s96-c"
/// isVerified : true
/// isExternalLogin : true
/// countryCode : ""
/// mobileNumber : ""
/// stream : {"streamId":1,"streamName":"Science","image":""}
/// createdOn : ""
/// modifiedOn : ""

class JsonData {
  int _userId;
  String _firstName;
  String _lastName;
  String _username;
  String _picture;
  bool _isVerified;
  bool _isExternalLogin;
  String _countryCode;
  String _mobileNumber;
  Stream _stream;
  String _createdOn;
  String _modifiedOn;

  int get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get username => _username;
  String get picture => _picture;
  bool get isVerified => _isVerified;
  bool get isExternalLogin => _isExternalLogin;
  String get countryCode => _countryCode;
  String get mobileNumber => _mobileNumber;
  Stream get stream => _stream;
  String get createdOn => _createdOn;
  String get modifiedOn => _modifiedOn;

  JsonData({
      int userId, 
      String firstName, 
      String lastName, 
      String username, 
      String picture, 
      bool isVerified, 
      bool isExternalLogin, 
      String countryCode, 
      String mobileNumber, 
      Stream stream, 
      String createdOn, 
      String modifiedOn}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _picture = picture;
    _isVerified = isVerified;
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
    _isVerified = json["isVerified"];
    _isExternalLogin = json["isExternalLogin"];
    _countryCode = json["countryCode"];
    _mobileNumber = json["mobileNumber"];
    _stream = json["stream"] != null ? Stream.fromJson(json["stream"]) : null;
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
    map["isVerified"] = _isVerified;
    map["isExternalLogin"] = _isExternalLogin;
    map["countryCode"] = _countryCode;
    map["mobileNumber"] = _mobileNumber;
    if (_stream != null) {
      map["stream"] = _stream.toJson();
    }
    map["createdOn"] = _createdOn;
    map["modifiedOn"] = _modifiedOn;
    return map;
  }

}

/// streamId : 1
/// streamName : "Science"
/// image : ""

class Stream {
  int _streamId;
  String _streamName;
  String _image;

  int get streamId => _streamId;
  String get streamName => _streamName;
  String get image => _image;

  Stream({
      int streamId, 
      String streamName, 
      String image}){
    _streamId = streamId;
    _streamName = streamName;
    _image = image;
}

  Stream.fromJson(dynamic json) {
    _streamId = json["streamId"];
    _streamName = json["streamName"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["streamId"] = _streamId;
    map["streamName"] = _streamName;
    map["image"] = _image;
    return map;
  }

}