import '../../../../base/model/base_network_model.dart';
import 'error_model_interface.dart';

abstract class IResponseModel<T, E extends INetworkModel<E>> {
  T? data;
  IErrorModel<E>? error;
}
