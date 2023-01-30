import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

//import 'package:vexana/vexana.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends INetworkModel<LoginModel> {
  final String? email;
  final String? password;
  LoginModel({this.email, this.password});
  @override
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  LoginModel fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }
}
