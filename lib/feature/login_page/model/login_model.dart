import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/core/base/model/base_network_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends INetworkModel<LoginModel> {
  final String email;
  final String password;
  LoginModel({required this.email, required this.password});
  @override
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  LoginModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
