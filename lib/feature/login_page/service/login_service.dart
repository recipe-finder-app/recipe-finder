import 'package:recipe_finder/core/constant/enum/service_path_enum.dart';
import 'package:recipe_finder/core/init/network/vexana/vexana_manager.dart';
import 'package:recipe_finder/feature/login_page/model/register_response_model.dart';
import 'package:vexana/vexana.dart';

import '../model/login_model.dart';
import '../model/login_response_model.dart';
import '../model/register_model.dart';

abstract class ILoginService {
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password);
  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String username, String email, String password);
}

class LoginService extends ILoginService {
  @override
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password) async {
    final response = VexanaManager.instance.networkManager.send<LoginResponseModel, LoginResponseModel>(ServicePath.login.path, parseModel: LoginResponseModel(), method: RequestType.POST, data: LoginModel(username: email, password: password));
    return response;
  }

  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String userName, String email, String password) async {
    final response = VexanaManager.instance.networkManager
        .send<RegisterResponseModel, RegisterResponseModel>(ServicePath.register.path, parseModel: RegisterResponseModel(), method: RequestType.POST, data: RegisterModel(username: userName, email: email, password: password));
    return response;
  }
}
