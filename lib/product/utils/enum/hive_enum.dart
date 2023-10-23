enum HiveBoxEnum {
  userModel,
  materialSearchMap,
}

enum HiveKeyEnum {
  user,
  materialSearchMap,
}

enum HiveAdapterKeyEnum {
  userAdapter(1),
  ingredientModelAdapter(2),
  ingredientQuantityAdapter(3),
  ingredientsOfCategoryModelAdapter(4),
  categoryOfIngredientModelAdapter(5),
  materialSearchModelAdapter(6),
  categoryOfRecipesModelAdapter(7),
  recipeModelAdapter(8);

  const HiveAdapterKeyEnum(this.value);
  final int value;
}
