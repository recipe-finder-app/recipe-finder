import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'token_verification_response_model.g.dart';

@JsonSerializable()
class TokenVerificationResponseModel extends INetworkModel<TokenVerificationResponseModel> {
  final bool? success;
  final String? message;
  TokenVerificationResponseModel({this.success, this.message});

  @override
  factory TokenVerificationResponseModel.fromJson(Map<String, dynamic> json) => _$TokenVerificationResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenVerificationResponseModelToJson(this);

  @override
  TokenVerificationResponseModel fromJson(Map<String, dynamic> json) {
    return _$TokenVerificationResponseModelFromJson(json);
  }
}
