// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_verification_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenVerificationResponseModel _$TokenVerificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    TokenVerificationResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$TokenVerificationResponseModelToJson(
        TokenVerificationResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
