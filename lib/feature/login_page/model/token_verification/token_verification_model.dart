import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'token_verification_model.g.dart';

@JsonSerializable()
class TokenVerificationModel extends INetworkModel<TokenVerificationModel> {
  final String? password;
  TokenVerificationModel({this.password});
  @override
  factory TokenVerificationModel.fromJson(Map<String, dynamic> json) => _$TokenVerificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenVerificationModelToJson(this);

  @override
  TokenVerificationModel fromJson(Map<String, dynamic> json) {
    return _$TokenVerificationModelFromJson(json);
  }
}
