import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
import 'package:recipe_finder/product/utils/enum/firebase_collection_enum.dart';

import '../model/ingredient_quantity/ingredient_quantity.dart';

abstract class ICommonService {
  late CollectionReference users;
  late CollectionReference recipes;
  late CollectionReference recipeCategories;
Future<bool> isContainsRecipeInLikedRecipelist(String userId,String recipeId);
  Future<List<Recipe>> fetchLikedRecipes(String userId);
  Future<void> removeItemFromLikedRecipes(String userId,String recipeId);
  Future<void> addItemToLikedRecipes(String userId,Recipe model);
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
    final response = await users
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
        .get();
       
    for (var ingredient in response.docs) {
      final data =  ingredient.data();
      if (data != null) {
        myList.add(data);
      }
    }
    return myList;
  }
  
  @override
  Future<void> addItemToLikedRecipes(String userId,Recipe model) async {
 final likedRecipeDoc = users.doc(userId).collection(FirebaseCollectionEnum.liked_recipes.name).doc(model.id);
 await likedRecipeDoc.set(
     model.toJson()
    );
    for(IngredientQuantity ingredient in (model.ingredients ?? [])){
 await likedRecipeDoc.collection(FirebaseCollectionEnum.ingredients.name).doc(ingredient.id).set(
  ingredient.toJson()
 );
    }
     for(RecipeCategory category in (model.categories ?? [])){
 await likedRecipeDoc.collection(FirebaseCollectionEnum.categories.name).doc(category.id).set(
  category.toJson()
 );
    }
 
  }
   @override
  Future<void> removeItemFromLikedRecipes(String userId,String recipeId) async {
 await users.doc(userId).collection(FirebaseCollectionEnum.liked_recipes.name).doc(recipeId).delete();

  }
  
  @override
  Future<List<Recipe>> fetchLikedRecipes(String userId) async {
   List<Recipe> myList = [];
   List<RecipeCategory> categoryList = [];
   List<IngredientQuantity> ingredientList = [];
    final userResponse = await users
        .doc(userId)
        .collection(FirebaseCollectionEnum.liked_recipes.name)
        .withConverter(fromFirestore: (snapshot, options) {
          final jsonBody = snapshot.data();
          if (jsonBody != null) {
            jsonBody['id'] = snapshot.id;
            return Recipe.fromJson(jsonBody);
          }
        }, toFirestore: (value, options) {
          if (value == null) throw Exception('$value is null');
          return value.toJson();
        }).get();
       
    for (var recipe in userResponse.docs) {
      final recipeData =  recipe.data();
      if (recipeData != null) {
       final categoryResponse = await users
        .doc(userId)
        .collection(FirebaseCollectionEnum.liked_recipes.name).doc(recipeData.id).collection(FirebaseCollectionEnum.categories.name).withConverter(fromFirestore: (snapshot, options) {
          final jsonBody = snapshot.data();
          if (jsonBody != null) {
            jsonBody['id'] = snapshot.id;
            return RecipeCategory.fromJson(jsonBody);
          }
        }, toFirestore: (value, options) {
          if (value == null) throw Exception('$value is null');
          return value.toJson();
        }).get();

        for(var category in categoryResponse.docs){
           final categoryData =  category.data();
          if(categoryData!=null) {
            categoryList.add(categoryData);
          }
        }
         final ingredientResponse = await users
        .doc(userId)
        .collection(FirebaseCollectionEnum.liked_recipes.name).doc(recipeData.id).collection(FirebaseCollectionEnum.ingredients.name).withConverter(fromFirestore: (snapshot, options) {
          final jsonBody = snapshot.data();
          if (jsonBody != null) {
            jsonBody['id'] = snapshot.id;
            return IngredientQuantity.fromJson(jsonBody);
          }
        }, toFirestore: (value, options) {
          if (value == null) throw Exception('$value is null');
          return value.toJson();
        }).get();

         for(var ingredient in ingredientResponse.docs){
          final ingredientData = ingredient.data();
          if(ingredientData!=null) {
            ingredientList.add(ingredientData);
          }
        }
          final  fixedRecipeList=recipeData.copyWith(categories: categoryList,ingredients: ingredientList);
        myList.add(fixedRecipeList);
      }
    }
    return myList;
  }
  
  @override
  Future<bool> isContainsRecipeInLikedRecipelist(String userId, String recipeId) async {
  final response = await users.doc(userId).collection(FirebaseCollectionEnum.liked_recipes.name).doc(recipeId).withConverter(fromFirestore: (snapshot, options) {
      final jsonBody = snapshot.data();
      if (jsonBody != null) {
        jsonBody['id'] = snapshot.id;
        return Recipe.fromJson(jsonBody);
      }
    }, toFirestore: (value, options) {
      if (value == null) throw Exception('$value is null');
      return value.toJson();
    }).get();
    final data = response.data();
    if(data!=null){
    if(data.id==recipeId){
      return true;
    }
    else {
      return false;
    }
    }
    else {
      return false;
    }
  }
}
