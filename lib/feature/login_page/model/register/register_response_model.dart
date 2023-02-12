import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel extends INetworkModel<RegisterResponseModel> {
  final RegisterData? data;
  final String? message;
  final String? token;
  final bool? success;
  RegisterResponseModel({this.data, this.message, this.token, this.success});
  @override
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);

  @override
  RegisterResponseModel fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseModelFromJson(json);
  }
}

@JsonSerializable()
class RegisterData {
  final String? email;
  final String? username;
  @JsonKey(name: '_id')
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  RegisterData(this.email, this.username, this.id, this.createdAt, this.updatedAt);
  factory RegisterData.fromJson(Map<String, dynamic> json) => _$RegisterDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);

  @override
  RegisterData fromJson(Map<String, dynamic> json) {
    return _$RegisterDataFromJson(json);
  }
}
