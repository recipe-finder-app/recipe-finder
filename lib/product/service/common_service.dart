import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
import 'package:recipe_finder/product/utils/enum/firebase_collection_enum.dart';

import '../model/ingredient_quantity/ingredient_quantity.dart';

abstract class ICommonService {
  late CollectionReference users;
  late CollectionReference recipes;
  late CollectionReference recipeCategories;
  Future<List<IngredientQuantity>> fetchAllFrizeItemList(String userId);
  CollectionReference<Recipe?> fetchAllRecipeList();
  Future<List<QueryDocumentSnapshot<Recipe?>>> fetchRecipeListWithLimit({required int limit});
  Future<List<QueryDocumentSnapshot<RecipeCategory?>>> fetchRecipeSubCategories({required String recipeId});
  Future<List<QueryDocumentSnapshot<IngredientQuantity?>>> fetchRecipeSubIngredients({required String recipeId});
  Future<List<QueryDocumentSnapshot<RecipeCategory?>>> fetchRecipeCategoryList();
}

class CommonService implements ICommonService {
  @override
  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.users.name);
  @override
  @override
  CollectionReference recipes = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.recipes.name);
  @override
  CollectionReference<Object?> recipeCategories = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.recipe_categories.name);
  @override
  CollectionReference<Recipe?> fetchAllRecipeList() {
    final response = recipes.withConverter(fromFirestore: (snapshot, options) {
      final jsonBody = snapshot.data();
      if (jsonBody != null) {
        jsonBody['id'] = snapshot.id;
        return Recipe.fromJson(jsonBody);
      }
    }, toFirestore: (value, options) {
      if (value == null) throw Exception('$value is null');
      return value.toJson();
    });
    return response;
  }

  @override
  Future<List<QueryDocumentSnapshot<Recipe?>>> fetchRecipeListWithLimit({required int limit}) async {
    final response = await recipes
        .withConverter(fromFirestore: (snapshot, options) {
          final jsonBody = snapshot.data();
          if (jsonBody != null) {
            jsonBody['id'] = snapshot.id;
            return Recipe.fromJson(jsonBody);
          }
        }, toFirestore: (value, options) {
          if (value == null) throw Exception('$value is null');
          return value.toJson();
        })
        .limit(limit)
        .get();
    return response.docs;
  }

  @override
  Future<List<QueryDocumentSnapshot<RecipeCategory?>>> fetchRecipeSubCategories({required String recipeId}) async {
    final response = await recipes.doc(recipeId).collection(FirebaseCollectionEnum.categories.name).withConverter(fromFirestore: (snapshot, options) {
      final jsonBody = snapshot.data();
      if (jsonBody != null) {
        jsonBody['id'] = snapshot.id;
        return RecipeCategory.fromJson(jsonBody);
      }
    }, toFirestore: (value, options) {
      if (value == null) throw Exception('$value is null');
      return value.toJson();
    }).get();
    return response.docs;
  }

  @override
  Future<List<QueryDocumentSnapshot<IngredientQuantity?>>> fetchRecipeSubIngredients({required String recipeId}) async {
    final response = await recipes.doc(recipeId).collection(FirebaseCollectionEnum.ingredients.name).withConverter(fromFirestore: (snapshot, options) {
      final jsonBody = snapshot.data();
      if (jsonBody != null) {
        jsonBody['id'] = snapshot.id;
        return IngredientQuantity.fromJson(jsonBody);
      }
    }, toFirestore: (value, options) {
      if (value == null) throw Exception('$value is null');
      return value.toJson();
    }).get();
    return response.docs;
  }

  @override
  Future<List<QueryDocumentSnapshot<RecipeCategory?>>> fetchRecipeCategoryList() async {
    final response = await recipeCategories.withConverter(fromFirestore: (snapshot, options) {
      final jsonBody = snapshot.data();
      if (jsonBody != null) {
        // jsonBody.addEntries([MapEntry('id',snapshot.id)]);
        jsonBody['id'] = snapshot.id;
        return RecipeCategory.fromJson(jsonBody);
      }
    }, toFirestore: (value, options) {
      if (value == null) throw Exception('$value is null');
      return value.toJson();
    }).get();

    return response.docs;
  }

  @override
  Future<List<IngredientQuantity>> fetchAllFrizeItemList(String userId) async {
    List<IngredientQuantity> myList = [];
    await users
        .doc(userId)
        .collection(FirebaseCollectionEnum.frize.name)
        .withConverter(fromFirestore: (snapshot, options) {
          final jsonBody = snapshot.data();
          if (jsonBody != null) {
            jsonBody['id'] = snapshot.id;
            return IngredientQuantity.fromJson(jsonBody);
          }
        }, toFirestore: (value, options) {
          if (value == null) throw Exception('$value is null');
          return value.toJson();
        })
        .get()
        .then((response) {
          for (var ingredient in response.docs) {
            final ingredientData = ingredient.data();
            debugPrint("nametr ${ingredientData?.nameTR}");
            if (ingredientData != null) {
              myList.add(ingredientData);
            }
          }
          return myList;
        });
    return myList;
  }
}
