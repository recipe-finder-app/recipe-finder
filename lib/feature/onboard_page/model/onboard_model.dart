import 'package:motaperp_sosyal/core/constant/app/app_constants.dart';

import '../../../core/base/model/base_model.dart';

enum OnboardPageType {
  name,
  department,
  idPass,
}

class OnboardModel extends IBaseModel<OnboardModel> {
  OnboardPageType? pageType;
  String? nameSurname;
  String? departmentId;
  String? userName;
  String? password;

  OnboardModel(
      {this.pageType,
      this.nameSurname,
      this.departmentId,
      this.userName,
      this.password});

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['db_name'] = ApplicationConstants.DB_NAME;
    data['db_userName'] = ApplicationConstants.DB_USER;
    data['db_password'] = ApplicationConstants.DB_PASS;
    data['pageType'] = pageType ?? '';
    data['nameSurname'] = nameSurname ?? '';
    data['departmentId'] = departmentId ?? '';
    data['userName'] = userName ?? '';
    data['password'] = password ?? '';

    return data;
  }

  @override
  OnboardModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
