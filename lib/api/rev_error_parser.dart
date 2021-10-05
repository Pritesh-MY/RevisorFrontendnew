import 'package:revisor/ui/base/base_view.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class RevErrorParser {
  static parseError(dynamic e, BaseView view) {
/*
    if (e is DioError) {
      var data = e.response.data;
      if (data is Map && data.containsKey('error_description')) print('true');
*/

    view.onError(e?.response?.data?.toString() ?? "Some error occurred");
  }
}

abstract class KitErrorType {
  static const UNAUTHORIZED = 401;
}
