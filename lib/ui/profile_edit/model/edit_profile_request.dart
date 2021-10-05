/// firstName : "string"
/// lastName : "string"
/// username : "user@example.com"

class EditProfileRequest {
  String _firstName;
  String _lastName;
  String _username;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get username => _username;

  EditProfileRequest({
      String firstName, 
      String lastName, 
      String username}){
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
}

  EditProfileRequest.fromJson(dynamic json) {
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _username = json["username"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["username"] = _username;
    return map;
  }

  set username(String value) {
    _username = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set firstName(String value) {
    _firstName = value;
  }
}