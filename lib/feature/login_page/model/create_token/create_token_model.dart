import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

//import 'package:vexana/vexana.dart';

part 'login_model.g.dart';

@JsonSerializable()
class CreateTokenModel extends INetworkModel<LoginModel> {
  final String? username;
  final String? password;
  CreateTokenModel({this.username, this.password});
  @override
  factory CreateTokenModel.fromJson(Map<String, dynamic> json) => _$CreateTokenModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateTokenModelToJson(this);

  @override
  CreateTokenModel fromJson(Map<String, dynamic> json) {
    return _$CreateTokenModelFromJson(json);
  }
}
