//import '../../core/init/network/dio/interface/base_network_model.dart';

import 'package:vexana/vexana.dart';

class BaseErrorModel extends INetworkModel<BaseErrorModel> {
  bool? success;
  String? message;

  BaseErrorModel({this.success, this.message});

  BaseErrorModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }
    success = json['success'] as bool?;
    message = json['message'] as String?;
  }

  @override
  Map<String, Object> toJson() {
    final data = <String, Object>{};
    data['success'] = success ?? '';
    data['message'] = message ?? '';
    return data;
  }

  @override
  BaseErrorModel fromJson(Map<String, dynamic>? json) {
    return BaseErrorModel.fromJson(json);
  }
}
