import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category.dart';
import 'package:recipe_finder/product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:recipe_finder/product/utils/enum/firebase_collection_enum.dart';


abstract class IMaterialSearchService {
 /* Future<IResponseModel<CategoryOfIngredientListModel?, INetworkModel<dynamic>?>> categoryOfIngredient();
  Future<IResponseModel<IngredientsOfCategoryModel?, INetworkModel<dynamic>?>> ingredientsOfCategory(String categoryId)*/
 CollectionReference<IngredientCategory?> fetchIngredientCategories();
 CollectionReference<IngredientQuantity?> fetchIngredientList();
}

class MaterialSearchService implements IMaterialSearchService {
  var ingredientCategories = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.ingredient_categories.name);
  var ingredients = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.ingredients.name);
  @override
  CollectionReference<IngredientCategory?> fetchIngredientCategories() {
    final response = ingredientCategories.withConverter(
      fromFirestore: (snapshot,options){
        final jsonBody = snapshot.data();
       
        if(jsonBody!=null) {
          return IngredientCategory.fromJson(jsonBody)..copyWith(id: snapshot.id);
        }
      },
       toFirestore: (value,options){
        if (value == null) throw Exception('$value is null');
        return value.toJson();
       }
       );
      return response;
      
  }
  
  @override
  CollectionReference<IngredientQuantity?> fetchIngredientList() {
    final response = ingredients.withConverter(
      fromFirestore: (snapshot,options){
        final jsonBody = snapshot.data();
        if(jsonBody!=null) {
          return IngredientQuantity.fromJson(jsonBody)..copyWith(id: snapshot.id);
        }
      },
       toFirestore: (value,options){
        if (value == null) throw Exception('$value is null');
        return value.toJson();
       }
       );
      return response;
  }
 /* @override
  Future<IResponseModel<CategoryOfIngredientListModel?, INetworkModel?>> categoryOfIngredient() {
    final response = VexanaManager.instance.networkManager.send<CategoryOfIngredientListModel, CategoryOfIngredientListModel>(ServicePath.categoryOfIngredient, parseModel: CategoryOfIngredientListModel(), method: RequestType.GET);
    return response;
  }

  Future<IResponseModel<IngredientsOfCategoryModel?, INetworkModel?>> ingredientsOfCategory(String categoryId) {
    final response = VexanaManager.instance.networkManager.send<IngredientsOfCategoryModel, IngredientsOfCategoryModel>(("${ServicePath.ingredientsOfCategory}/$categoryId"), parseModel: IngredientsOfCategoryModel(), method: RequestType.GET);
    return response;
  }*/
}
