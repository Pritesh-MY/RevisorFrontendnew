import 'package:flutter/material.dart';
import 'package:revisor/ui/selectStream/model/stream_response.dart';

class SubjectStreamProvider extends ChangeNotifier {
  JsonData _currentSelectedStream;
  List<JsonData> _subjectStreamList = [];

  void addAddress(JsonData value) {
    _subjectStreamList.add(value);
    notifyListeners();
  }

  void update(JsonData value) {
    _currentSelectedStream = value;
    for (var customerAddress in _subjectStreamList)
      if (value == customerAddress)
        customerAddress.isSelected = true;
      else
        customerAddress.isSelected = false;

    notifyListeners();
  }

  void clearGenre() {
    _subjectStreamList.clear();
    notifyListeners();
  }

  List<JsonData> get streamList => _subjectStreamList;

  JsonData get currentSelection => _currentSelectedStream ?? null;

  set currentSelection(JsonData value) {
    _currentSelectedStream = value;
  }
}
