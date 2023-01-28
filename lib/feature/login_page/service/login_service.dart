import 'package:dio/dio.dart';
import 'package:recipe_finder/feature/login_page/model/login_response_model.dart';

import '../../../core/constant/enum/http_request_enum.dart';
import '../../../core/init/network/dio/network_manager.dart';
import '../model/login_model.dart';

abstract class ILoginService {
  void postLogin();
}

class LoginService implements ILoginService {
  final networkManager = NetworkManager<LoginModel>(
      options: BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  ));
  @override
  Future<void> postLogin() async {
    final response = await networkManager.send<LoginModel, LoginResponseModel>('/posts/1', parseModel: LoginResponseModel(), httpType: HttpTypes.POST);
  }
}
