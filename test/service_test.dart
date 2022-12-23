import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/core/base/model/base_network_model.dart';
import 'package:recipe_finder/core/constant/enum/http_request_enum.dart';
import 'package:recipe_finder/core/init/network/dio/interface/network_manager_interface.dart';
import 'package:recipe_finder/core/init/network/dio/network_manager.dart';

main() {
  late INetworkManager networkManager;
  setUp(() {
    networkManager = NetworkManager<UserModel>(
        options: BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ));
  });
  test('service', () async {
    final response = await networkManager.send<UserModel, UserModel>('/posts/1',
        parseModel: UserModel(), type: HttpTypes.GET);

    expect(response.model, isNotNull);
  });
}

class UserModel extends INetworkModel<UserModel> {
  int? userId;
  int? id;
  String? title;
  String? body;

  UserModel({this.userId, this.id, this.title, this.body});

  UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }
    userId = json['userId'] as int?;
    id = json['id'] as int?;
    title = json['title'] as String?;
    body = json['body'] as String?;
  }

  @override
  Map<String, Object> toJson() {
    final data = <String, Object>{};
    data['userId'] = userId ?? '';
    data['id'] = id ?? '';
    data['title'] = title ?? '';
    data['body'] = body ?? '';
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic>? json) {
    return UserModel.fromJson(json);
  }
}
