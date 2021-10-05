/// message : "Your report is successfully sent on you mail"
/// status : true
/// data : null

class ReportResponse {
  ReportResponse({
      String message, 
      bool status, 
      dynamic data,}){
    _message = message;
    _status = status;
    _data = data;
}

  ReportResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'];
  }
  String _message;
  bool _status;
  dynamic _data;

  String get message => _message;
  bool get status => _status;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    map['data'] = _data;
    return map;
  }

}