import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel implements INetworkModel<TokenModel> {
  @JsonKey(name: 'Authorization')
  final String? token;
  TokenModel({this.token});

  @override
  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  @override
  TokenModel fromJson(Map<String, dynamic> json) {
    return _$TokenModelFromJson(json);
  }
}
