import 'package:hive_flutter/adapters.dart';

import '../../constant/enum/hive_enum.dart';

abstract class IHiveManager<T> {
  HiveBoxEnum hiveBoxName;
  Box<T>? _box;
  IHiveManager(this.hiveBoxName);
  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(hiveBoxName.name);
    }
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  T? getItem(HiveKeyEnum key);
  List<T>? getValues();
  Future<void> putItem(HiveKeyEnum key, T value);
  Future<void> removeItem(HiveKeyEnum key);
  void registerAdapters();
}

class HiveManager<T> extends IHiveManager<T> {
  HiveManager(super.hiveBoxName);

  @override
  Future<void> addItems(List<T> items) async {
    await _box?.addAll(items);
  }

  @override
  T? getItem(HiveKeyEnum key) {
    return _box?.get(key.name);
  }

  @override
  List<T>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> putItem(HiveKeyEnum key, T value) async {
    await _box?.put(key.name, value);
  }

  @override
  Future<void> putItems(List<T> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e, e))));
  }

  @override
  Future<void> removeItem(HiveKeyEnum key) async {
    await _box?.delete(key.name);
  }

  @override
  void registerAdapters() {
    /* if (!Hive.isAdapterRegistered(HiveBoxEnum.userId)) {
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(CompanyAdapter());
    }*/
  }
}
