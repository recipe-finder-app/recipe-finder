import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/base_network_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  final bool? success;
  final String? token;
  LoginResponseModel({this.success, this.token});

  @override
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
