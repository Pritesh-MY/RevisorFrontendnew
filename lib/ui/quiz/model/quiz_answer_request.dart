/// userId : 0
/// chapterId : 0
/// userAnswers : [{"questionId":0,"conceptNumber":0,"isCorrect":true}]

class QuizAnswerRequest {
  QuizAnswerRequest({
    int userId,
    int chapterId,
    List<UserAnswers> userAnswers,
  }) {
    _userId = userId;
    _chapterId = chapterId;
    _userAnswers = userAnswers;
  }

  QuizAnswerRequest.fromJson(dynamic json) {
    _userId = json['userId'];
    _chapterId = json['chapterId'];
    if (json['userAnswers'] != null) {
      _userAnswers = [];
      json['userAnswers'].forEach((v) {
        _userAnswers.add(UserAnswers.fromJson(v));
      });
    }
  }

  int _userId;
  int _chapterId;
  List<UserAnswers> _userAnswers;

  int get userId => _userId;

  int get chapterId => _chapterId;

  List<UserAnswers> get userAnswers => _userAnswers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['chapterId'] = _chapterId;
    if (_userAnswers != null) {
      map['userAnswers'] = _userAnswers.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set userAnswers(List<UserAnswers> value) {
    _userAnswers = value;
  }

  set chapterId(int value) {
    _chapterId = value;
  }

  set userId(int value) {
    _userId = value;
  }
}

/// questionId : 0
/// conceptNumber : 0
/// isCorrect : true

class UserAnswers {
  UserAnswers(int questionId, num conceptNumber, bool isCorrect) {
    _questionId = questionId;
    _conceptNumber = conceptNumber;
    _isCorrect = isCorrect;
  }

  UserAnswers.fromJson(dynamic json) {
    _questionId = json['questionId'];
    _conceptNumber = json['conceptNumber'];
    _isCorrect = json['isCorrect'];
  }

  int _questionId;
  num _conceptNumber;
  bool _isCorrect;

  int get questionId => _questionId;

  int get conceptNumber => _conceptNumber;

  bool get isCorrect => _isCorrect;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = _questionId;
    map['conceptNumber'] = _conceptNumber;
    map['isCorrect'] = _isCorrect;
    return map;
  }

  set isCorrect(bool value) {
    _isCorrect = value;
  }

  set conceptNumber(int value) {
    _conceptNumber = value;
  }

  set questionId(int value) {
    _questionId = value;
  }
}
