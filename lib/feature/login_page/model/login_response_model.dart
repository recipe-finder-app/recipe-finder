import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

//import 'package:vexana/vexana.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  final bool? success;
  final String? token;
  final String? message;
  LoginResponseModel({this.success, this.token, this.message});

  @override
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
}
