import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'create_token_model.g.dart';

@JsonSerializable()
class CreateTokenModel extends INetworkModel<CreateTokenModel> {
  final String? email;
  CreateTokenModel({
    this.email,
  });
  @override
  factory CreateTokenModel.fromJson(Map<String, dynamic> json) => _$CreateTokenModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateTokenModelToJson(this);

  @override
  CreateTokenModel fromJson(Map<String, dynamic> json) {
    return _$CreateTokenModelFromJson(json);
  }
}
