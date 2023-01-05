import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../base/model/base_network_model.dart';
import '../../../constant/enum/http_request_enum.dart';
import 'interface/network_manager_interface.dart';
import 'interface/response_model_interface.dart';
import 'model/empty_model.dart';
import 'model/error_model.dart';
import 'model/responseModel.dart';

class NetworkManager<E extends INetworkModel<E>> with DioMixin implements Dio, INetworkManager<E> {
  @override
  final BaseOptions options;
  E? errorModel;
  E? Function(Map<String, dynamic> data)? errorModelFromData;

  NetworkManager({required this.options, this.errorModel, this.errorModelFromData}) {
    options = options;
    interceptors.add(InterceptorsWrapper());
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  @override
  Future<IResponseModel<R?, E>> send<R, T extends INetworkModel>(String path, {required HttpTypes httpType, required T parseModel, dynamic data, Map<String, dynamic>? queryParameters, void Function(int, int)? onReceiveProgress}) async {
    final body = _getBodyModel(data);
    try {
      final response = await request(path,
          data: body,
          options: Options(
            method: httpType.name,
          ));
      switch (response.statusCode ?? HttpStatus.notFound) {
        case HttpStatus.ok:
        case HttpStatus.accepted:
          var _response = response.data;
          return _getResponseResult<T, R>(_response, parseModel);
        default:
          return ResponseModel(error: ErrorModel(description: response.data.toString()));
      }
    } on DioError catch (error) {
      return _onError(error);
    }
  }

  dynamic _getBodyModel(dynamic data) {
    if (data is INetworkModel) {
      return data.toJson();
    } else if (data != null) {
      return jsonEncode(data);
    } else {
      return data;
    }
  }

  ResponseModel<R, E> _getResponseResult<T extends INetworkModel, R>(dynamic data, T parserModel) {
    final model = _parseBody<R, T>(data, parserModel);

    return ResponseModel<R, E>(model: model);
  }

  R? _parseBody<R, T extends INetworkModel>(dynamic responseBody, T model) {
    try {
      if (responseBody is List) {
        return responseBody.map((data) => model.fromJson(data)).cast<T>().toList() as R;
      } else if (responseBody is Map<String, dynamic>) {
        return model.fromJson(responseBody) as R;
      } else {
        if (R is EmptyModel || R == EmptyModel) {
          return EmptyModel(name: responseBody.toString()) as R;
        } else {
          /* CustomLogger(isEnabled: isEnableLogger).printError(
              'Becareful your data $responseBody, I could not parse it');*/
          return null;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      /* CustomLogger(isEnabled: isEnableLogger).printError(
          'Parse Error: $e - response body: $responseBody T model: $T , R model: $R ');*/
    }
    return null;
  }

  ErrorModel<E> _generateErrorModel(ErrorModel<E> error, dynamic data) {
    if (errorModel == null) {
    } else if (data is String || data is Map<String, dynamic>) {
      final json = data is String ? jsonDecode(data) : data as Map<String, dynamic>;

      if (errorModelFromData != null) {
        error = error.copyWith(model: errorModelFromData?.call(data));
      } else {
        error = error.copyWith(model: errorModel!..fromJson(json));
      }
    }

    return error;
  }

  ResponseModel<R, E> _onError<R>(DioError e) {
    final errorResponse = e.response;
    if (kDebugMode) {
      print(e.message);
    }
    var error = ErrorModel<E>(description: e.message, statusCode: errorResponse != null ? errorResponse.statusCode : HttpStatus.internalServerError);
    if (errorResponse != null) {
      error = _generateErrorModel(error, errorResponse.data);
    }
    return ResponseModel<R, E>(
      error: ErrorModel<E>(description: error.description, model: error.model, statusCode: error.statusCode),
    );
  }

  dynamic _decodeBody(String body) async {
    return await compute(_parseAndDecode, body);
  }

  dynamic _parseAndDecode(String response) {
    return jsonDecode(response);
  }
}
