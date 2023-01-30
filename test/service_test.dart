import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

main() {
  late INetworkManager networkManager;
  setUp(() {
    networkManager = NetworkManager<UserModel>(
        options: BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ));
  });
  test('service', () async {
    final usermodel = UserModel(
      title: 'foo',
      body: 'bar',
      userId: 1,
    );
    var data = {
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    };
    final response = await networkManager.send<UserModel, UserModel>(
      '/posts',
      parseModel: UserModel(),
      method: RequestType.POST,
      data: data,
    );
    print(response.data?.body);
    print(response.error?.description);
    print(response.error?.statusCode);
    expect(response.data, isNotNull);
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
