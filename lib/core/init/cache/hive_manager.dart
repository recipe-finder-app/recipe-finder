import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_search_model.dart';

import '../../../product/model/ingredient/ingredient_model.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../../../product/model/ingredient_category/ingredients_of_category_model.dart';
import '../../../product/model/user_model.dart';
import '../../constant/enum/hive_enum.dart';

abstract class IHiveManager<T> {
  HiveBoxEnum hiveBoxName;
  Box<T>? _box;
  IHiveManager(this.hiveBoxName);
  Future<void> openBox() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(hiveBoxName.name);
    }
  }

  Future<void> close();
  Future<void> clear();

  Future<void> add(T item);
  Future<void> addAll(List<T> items);
  Future<void> putAll(List<T> items);
  T? get(HiveKeyEnum key);
  List<T>? getValues();
  Future<void> put(HiveKeyEnum key, T value);
  Future<void> delete(HiveKeyEnum key);
  T? getFirst();
  T? getLast();
  void registerAdapters();
}

class HiveManager<T> extends IHiveManager<T> {
  HiveManager(super.hiveBoxName);
  /*static HiveManager? _instance;

  HiveManager._init(super.hiveBoxName);

  factory HiveManager(HiveBoxEnum hiveBoxName) {
    _instance ??= HiveManager<T>._init(hiveBoxName);
    return _instance! as HiveManager<T>;
  }*/

  @override
  Future<void> close() async {
    await _box?.close();
  }

  @override
  Future<void> clear() async {
    await _box?.clear();
  }

  @override
  Future<void> addAll(List<T> items) async {
    await _box?.addAll(items);
  }

  @override
  T? get(HiveKeyEnum key) {
    return _box?.get(key.name);
  }

  @override
  List<T>? getValues() {
    return _box?.values.toList();
  }

  @override
  Future<void> add(T value) async {
    await _box?.add(value);
  }

  @override
  Future<void> put(HiveKeyEnum key, T value) async {
    await _box?.put(key.name, value);
  }

  @override
  Future<void> putAll(List<T> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e, e))));
  }

  @override
  Future<void> delete(HiveKeyEnum key) async {
    await _box?.delete(key.name);
  }

  @override
  T? getFirst() {
    return _box?.values?.first;
  }

  @override
  T? getLast() {
    return _box?.values?.last;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IngredientModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(IngredientsOfCategoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(CategoryOfIngredientModelAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(MaterialSearchModelAdapter());
    }
  }
}
