import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/feature/login_page/model/login/login_model.dart';
import 'package:recipe_finder/feature/login_page/model/login/login_response_model.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:vexana/vexana.dart';

main() {
  late INetworkManager networkManager;
  setUp(() {
    networkManager = NetworkManager<BaseErrorModel>(
      options: BaseOptions(
        baseUrl: 'https://tarifiyle-bul.onrender.com',
      ),
      errorModel: BaseErrorModel(),
    );
  });
  test('service', () async {
    var loginResponsemodel = LoginModel(username: 'm.kemalgordesli@gmail.comasd', password: 'mustafa123456');
    final response = await networkManager.send<LoginResponseModel, LoginResponseModel>('/api/users/login', parseModel: LoginResponseModel(), method: RequestType.POST, data: loginResponsemodel);
    print(response.data?.success);
    print(response.data?.token);
    print(response.error?.description);
    print(response.error?.model);
    expect(response.data?.success, isNotNull);
  });
}
