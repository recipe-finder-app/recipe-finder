import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_search_model.dart';
import 'package:recipe_finder/product/model/recipe/recipe_model.dart';
import 'package:recipe_finder/product/model/recipe_category/category_of_recipes.dart';

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
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.ingredientModelAdapter.value)) {
      Hive.registerAdapter(IngredientModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.ingredientsOfCategoryModelAdapter.value)) {
      Hive.registerAdapter(IngredientsOfCategoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.categoryOfIngredientModelAdapter.value)) {
      Hive.registerAdapter(CategoryOfIngredientModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.materialSearchModelAdapter.value)) {
      Hive.registerAdapter(MaterialSearchModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.categoryOfRecipesModelAdapter.value)) {
      Hive.registerAdapter(CategoryOfRecipesModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveAdapterKeyEnum.recipeModelAdapter.value)) {
      Hive.registerAdapter(RecipeModelAdapter());
    }
  }
}
