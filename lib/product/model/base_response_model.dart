import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/error_model.dart';

class BaseResponseModel extends Equatable {
    const BaseResponseModel({
    required this.success,
    this.message = '',
    this.error
  });

  final bool success;
  final String message;
  final BaseError? error;

@override
List<Object?> get props => [success, error,message];
  BaseResponseModel copyWith({
    bool? success,
     String? message,
    BaseError? error    
  }) {
    return BaseResponseModel(
          success: success ?? this.success,
          message: message ?? this.message,
      error: error ?? this.error
    );
  }
}