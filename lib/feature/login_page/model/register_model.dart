import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends INetworkModel<RegisterModel> {
  final String? username;
  final String? email;
  final String? password;
  RegisterModel({this.email, this.username, this.password});
  @override
  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  @override
  RegisterModel fromJson(Map<String, dynamic> json) {
    return _$RegisterModelFromJson(json);
  }
}
