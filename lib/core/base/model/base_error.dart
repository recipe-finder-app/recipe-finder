import '../../init/network/dio/IResponseModel.dart';

class BaseError extends IErrorModel {
  final String message;

  BaseError({required this.message});
}
