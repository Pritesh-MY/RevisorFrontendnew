/// message : "Username or password is incorrect"
/// status : false
/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class ErrorResponse {
  String _message;
  bool _status;

  String get message => _message;
  bool get status => _status;

  ErrorResponse({
      String message, 
      bool status}){
    _message = message;
    _status = status;
}

  ErrorResponse.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    return map;
  }

}