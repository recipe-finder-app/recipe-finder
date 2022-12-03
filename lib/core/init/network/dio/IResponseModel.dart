import 'package:recipe_finder/core/base/model/base_network_model.dart';

abstract class IResponseModel<T> {
  T? data;
  IErrorModel? error;
}

abstract class IErrorModel<T extends IBaseNetworkModel> {
  int? statusCode;
  String? description;
  T? model;
  dynamic response;
}

class ResponseModel<T> extends IResponseModel<T> {
  @override
  final T? data;

  @override
  final IErrorModel? error;

  ResponseModel({this.data, this.error});
}
