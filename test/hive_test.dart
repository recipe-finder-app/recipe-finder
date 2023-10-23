import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/product/utils/enum/hive_enum.dart';
import 'package:recipe_finder/core/init/cache/hive_manager.dart';
import 'package:recipe_finder/product/model/user_model.dart';

main() {
  setUp(() async {
    Hive..init('HiveDatabase');
    await Hive.initFlutter('HiveDatabase');
  });
  test('service', () async {
    final HiveManager<User> hiveManager = HiveManager<User>(HiveBoxEnum.userModel);
    await hiveManager.openBox();
    await hiveManager.put(
        HiveKeyEnum.user,
        User(
          id: '1',
          username: 'uraz',
          email: 'alkisuraz@gmail.com',
          password: '123456',
          token: 'asdasdadas',
        ));
    final getitem = await hiveManager.get(HiveKeyEnum.user);
    final getFirst = await hiveManager.getFirst();
    expect(getFirst, isNotNull);
  });
}
