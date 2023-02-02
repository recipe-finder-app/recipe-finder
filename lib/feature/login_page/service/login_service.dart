import 'package:vexana/vexana.dart';

import '../model/login_model.dart';
import '../model/login_response_model.dart';

abstract class ILoginService {
  late INetworkManager networkManager;
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password);
}

class LoginService extends ILoginService {
  @override
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password) async {
    /*var dio = Dio(BaseOptions(baseUrl: 'https://tarifiyle-bul.onrender.com'));
    final response = await dio.post('/api/users/login', data: LoginModel(email: email, password: password).toJson());
    return response;*/
    networkManager = NetworkManager<Null>(
        options: BaseOptions(
      baseUrl: 'https://tarifiyle-bul.onrender.com',
    ));
    final response = await networkManager.send<LoginResponseModel, LoginResponseModel>(
      '/api/users/login',
      parseModel: LoginResponseModel(),
      method: RequestType.POST,
      data: LoginModel(email: email, password: password),
      // m.kemalgordesli@gmail.com     mustafa123456
    );
    return response;
  }
}
