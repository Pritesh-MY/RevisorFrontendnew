/// firstName : "orange"
/// lastName : "color"
/// username : "orange14@gmail.com"
/// password : "orange123"
/// countryCode : "+91"
/// mobileNumber : "1122334489"

class SignupRequest {
  String _firstName;
  String _lastName;
  String _username;
  String _password;
  String _countryCode;
  String _mobileNumber;
  String  otp;

  String get firstName => _firstName??"";
  String get lastName => _lastName??"";
  String get username => _username??"";
  String get password => _password??"";
  String get countryCode => _countryCode??"";
  String get mobileNumber => _mobileNumber??"";


  set firstName(String value) {
    _firstName = value;
  }

  SignupRequest({
      String firstName, 
      String lastName, 
      String username, 
      String password, 
      String countryCode, 
      String mobileNumber}){
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _password = password;
    _countryCode = countryCode;
    _mobileNumber = mobileNumber;
}

  SignupRequest.fromJson(dynamic json) {
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _username = json["username"];
    _password = json["password"];
    _countryCode = json["countryCode"];
    _mobileNumber = json["mobileNumber"];
    otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["firstName"] = _firstName??" ";
    map["lastName"] = _lastName??"0";
    map["username"] = _username;
    map["password"] = _password;
    map["countryCode"] = "+91";
    map["mobileNumber"] = _mobileNumber;
    map["otp"] = otp;
    return map;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set username(String value) {
    _username = value;
  }

  set password(String value) {
    _password = value;
  }

  set countryCode(String value) {
    _countryCode = value;
  }

  set mobileNumber(String value) {
    _mobileNumber = value;
  }
}