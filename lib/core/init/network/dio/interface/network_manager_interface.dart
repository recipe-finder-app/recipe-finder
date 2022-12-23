import 'package:recipe_finder/core/init/network/dio/interface/response_model_interface.dart';

import '../../../../base/model/base_network_model.dart';
import '../../../../constant/enum/http_request_enum.dart';

abstract class INetworkManager<E extends INetworkModel<E>> {
  Future<IResponseModel<R?, E>> send<R, T extends INetworkModel>(String path,
      {required HttpTypes type,
      required T parseModel,
      dynamic data,
      Map<String, Object>? queryParameters,
      void Function(int, int)? onReceiveProgress});
}
