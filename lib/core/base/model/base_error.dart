import '../../init/network/dio/interface/error_model_interface.dart';

class BaseError extends IErrorModel {
  final String message;

  BaseError({required this.message});
}
