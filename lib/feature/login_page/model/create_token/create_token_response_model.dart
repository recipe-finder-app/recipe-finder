import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'create_token_response_model.g.dart';

@JsonSerializable()
class CreateTokenResponseModel extends INetworkModel<CreateTokenResponseModel> {
  final bool? success;
  CreateTokenResponseModel({this.success});

  @override
  factory CreateTokenResponseModel.fromJson(Map<String, dynamic> json) => _$CreateTokenResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateTokenResponseModelToJson(this);

  @override
  CreateTokenResponseModel fromJson(Map<String, dynamic> json) {
    return _$CreateTokenResponseModelFromJson(json);
  }
}
