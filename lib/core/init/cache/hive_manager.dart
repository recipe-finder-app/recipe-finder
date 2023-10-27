import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category.dart';
import 'package:recipe_finder/product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';

import '../../../product/model/ingredient/ingredient.dart';
import '../../../product/model/user/user_model.dart';
import '../../../product/utils/enum/hive_enum.dart';

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
  Future<T?> get(HiveKeyEnum key);
  Future<List<T>?> getValues();
  Future<void> put(HiveKeyEnum key, T value);
  Future<void> delete(HiveKeyEnum key);
  Future<T?> getFirst();
  Future<T?> getLast();
  void registerAdapters();
}

class HiveManager<T> extends IHiveManager<T> {
  HiveManager(super.hiveBoxName);
  @override
  Future<void> close() async {
    await openBox();
    await _box?.close();
  }

  @override
  Future<void> clear() async {
    await openBox();
    await _box?.clear();
  }

  @override
  Future<void> addAll(List<T> items) async {
    await openBox();
    await _box?.addAll(items);
  }

  @override
  Future<T?> get(HiveKeyEnum key) async {
    await openBox();
    return _box?.get(key.name);
  }

  @override
  Future<List<T>?> getValues() async {
    await openBox();
    return _box?.values.toList();
  }

  @override
  Future<void> add(T value) async {
    await openBox();
    await _box?.add(value);
  }

  @override
  Future<void> put(HiveKeyEnum key, T value) async {
    await openBox();
    await _box?.put(key.name, value);
  }

  @override
  Future<void> putAll(List<T> items) async {
    await openBox();
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e, e))));
  }

  @override
  Future<void> delete(HiveKeyEnum key) async {
    await openBox();
    await _box?.delete(key.name);
  }

  @override
  Future<T?> getFirst() async {
    await openBox();
    return _box?.values?.first;
  }

  @override
  Future<T?> getLast() async {
    await openBox();
    return _box?.values?.last;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.userAdapter.value)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.ingredientAdapter.value)) {
      Hive.registerAdapter(IngredientAdapter());
    }
     if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.ingredientCategoryAdapter.value)) {
      Hive.registerAdapter(IngredientCategoryAdapter());
    }
     if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.ingredientQuantityAdapter.value)) {
      Hive.registerAdapter(IngredientQuantityAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.recipeAdapter.value)) {
      Hive.registerAdapter(RecipeAdapter());
    }
     if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.recipeCategoryAdapter.value)) {
      Hive.registerAdapter(RecipeCategoryAdapter());
    }
  }
}
