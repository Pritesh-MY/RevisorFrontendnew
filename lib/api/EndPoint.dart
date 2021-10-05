/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class EndPoints {
  static const String BASE_URL = 'https://revisordotnet.herokuapp.com';

  static const String LOGIN = BASE_URL + '/api/Accounts/authenticate';
  static const String SIGN_UP = BASE_URL + '/api/Accounts/register';
  static const String VERIFY_OTP = BASE_URL + '/api/Accounts/verifyotp';
  static const String SEND_OTP = BASE_URL + '/api/Accounts/sendotp';
  static const String POST_QUIZ_ANSWERS = BASE_URL + '/api/Report/adduseranswer';
  static const String CREATE_QUIZ_REPORT = BASE_URL + '/api/Statment/createreportpdf';

  // static const String RESEND_OTP = BASE_URL + '/api/Accounts/resendotp';
  static const String SOCIAL_LOGIN = BASE_URL + '/api/Accounts/externalauthentication';
  static const String CHANGE_PASSWORD = BASE_URL + '/api/Accounts/forgotpassword';

  static const String GET_ALL_STREAMS = BASE_URL + '/api/Streams/getallstreams';
  static const String GET_ALL_CHAPTERS = BASE_URL + '/api/Terms/getalltermsbysubjectid';
  static const String GET_PROFILE_BY_UID = BASE_URL + '/api/Users/getuserprofilebyid';
  static const String GET_ALL_SUBJECT = BASE_URL + '/api/Subjects/getallsubjectsbystream';
  static const String GET_ALL_SUBJECT_BY_UID =
      BASE_URL + '/api/Subjects/getallsubjectsbyuseronbehalfofstream';
  static const String GET_ALL_QUIZ = BASE_URL + '/api/PortalRecords/getquizbychapterid';

  static const String PUT_SELECTED_STREAM = BASE_URL + '/api/Users/updatestreamtouseraccount';
  static const String PUT_UPDATE_PROFILE = BASE_URL + '/api/Users/updateuserprofile';
}
