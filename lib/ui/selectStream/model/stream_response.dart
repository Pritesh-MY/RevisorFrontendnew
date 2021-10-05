/// message : "Successfully"
/// status : true
/// data : {"jsonData":[{"streamId":3,"streamName":"Science","image":null}]}

class StreamResponse {
  String _message;
  bool _status;
  Data _data;

  String get message => _message;
  bool get status => _status;
  Data get data => _data;

  StreamResponse({
      String message, 
      bool status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  StreamResponse.fromJson(dynamic json) {
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

/// jsonData : [{"streamId":3,"streamName":"Science","image":null}]

class Data {
  List<JsonData> _jsonData;

  List<JsonData> get jsonData => _jsonData;

  Data({
      List<JsonData> jsonData}){
    _jsonData = jsonData;
}

  Data.fromJson(dynamic json) {
    if (json["jsonData"] != null) {
      _jsonData = [];
      json["jsonData"].forEach((v) {
        _jsonData.add(JsonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_jsonData != null) {
      map["jsonData"] = _jsonData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// streamId : 3
/// streamName : "Science"
/// image : null

class JsonData {
  int _streamId;
  String _streamName;
  dynamic _image;
  bool isSelected;


  int get streamId => _streamId;
  String get streamName => _streamName;
  dynamic get image => _image;

  JsonData({
      int streamId, 
      String streamName, 
      dynamic image}){
    _streamId = streamId;
    _streamName = streamName;
    _image = image;
}

  JsonData.fromJson(dynamic json) {
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