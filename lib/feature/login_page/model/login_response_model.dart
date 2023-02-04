import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/feature/login_page/model/register_response_model.dart';
import 'package:vexana/vexana.dart';

//import 'package:vexana/vexana.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  final bool? success;
  final LoginData? data;
  final String? token;
  final String? message;
  LoginResponseModel({this.success, this.data, this.token, this.message});

  @override
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
}

@JsonSerializable()
class LoginData {
  @JsonKey(name: '_id')
  final String? id;
  final String? email;
  final String? username;

  LoginData(this.email, this.username, this.id);
  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

  @override
  LoginData fromJson(Map<String, dynamic> json) {
    return _$LoginDataFromJson(json);
  }
}
