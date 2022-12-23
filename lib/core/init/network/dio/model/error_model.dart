import '../../../../base/model/base_network_model.dart';
import '../interface/error_model_interface.dart';

class ErrorModel<E extends INetworkModel<E>> extends IErrorModel<E> {
  @override
  final String? description;

  @override
  final E? model;

  @override
  final int? statusCode;

  ErrorModel({this.description, this.model, this.statusCode});

  ErrorModel<E> copyWith({
    int? statusCode,
    String? description,
    E? model,
  }) {
    return ErrorModel<E>(
      statusCode: statusCode ?? this.statusCode,
      description: description ?? this.description,
      model: model ?? this.model,
    );
  }
}
