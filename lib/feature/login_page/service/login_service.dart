import 'package:recipe_finder/core/init/network/vexana/vexana_manager.dart';
import 'package:recipe_finder/feature/login_page/model/create_token/create_token_model.dart';
import 'package:recipe_finder/feature/login_page/model/token_verification/token_verification_model.dart';
import 'package:recipe_finder/feature/login_page/model/token_verification/token_verification_response_model.dart';
import 'package:vexana/vexana.dart';

import '../../../core/constant/service/service_path.dart';
import '../model/create_token/create_token_response_model.dart';
import '../model/login/login_model.dart';
import '../model/login/login_response_model.dart';
import '../model/register/register_model.dart';
import '../model/register/register_response_model.dart';

abstract class ILoginService {
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password);
  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String username, String email, String password);
  Future<IResponseModel<CreateTokenResponseModel?, INetworkModel<dynamic>?>> createToken(String email);
  Future<IResponseModel<TokenVerificationResponseModel?, INetworkModel<dynamic>?>> tokenVerification(String Email, String verificationCode, String password);
}

class LoginService extends ILoginService {
  @override
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password) async {
    final response = VexanaManager.instance.networkManager.send<LoginResponseModel, LoginResponseModel>(ServicePath.login, parseModel: LoginResponseModel(), method: RequestType.POST, data: LoginModel(username: email, password: password));
    return response;
  }

  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String userName, String email, String password) async {
    final response = VexanaManager.instance.networkManager
        .send<RegisterResponseModel, RegisterResponseModel>(ServicePath.register, parseModel: RegisterResponseModel(), method: RequestType.POST, data: RegisterModel(username: userName, email: email, password: password));
    return response;
  }

  @override
  Future<IResponseModel<CreateTokenResponseModel?, INetworkModel?>> createToken(String email) {
    final response = VexanaManager.instance.networkManager.send<CreateTokenResponseModel, CreateTokenResponseModel>(ServicePath.resetPassword, parseModel: CreateTokenResponseModel(), method: RequestType.POST, data: CreateTokenModel(email: email));
    return response;
  }

  @override
  Future<IResponseModel<TokenVerificationResponseModel?, INetworkModel?>> tokenVerification(String email, String verificationCode, String password) {
    print('${ServicePath.resetPassword}/$email/$verificationCode');
    final response = VexanaManager.instance.networkManager.send<TokenVerificationResponseModel, TokenVerificationResponseModel>('${ServicePath.resetPassword}/$email/$verificationCode',
        parseModel: TokenVerificationResponseModel(), method: RequestType.POST, data: TokenVerificationModel(password: password));
    return response;
  }
}
