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
  ingredientsOfCategoryModelAdapter(3),
  categoryOfIngredientModelAdapter(4),
  materialSearchModelAdapter(5),
  categoryOfRecipesModelAdapter(6),
  recipeModelAdapter(7);

  const HiveAdapterKeyEnum(this.value);
  final int value;
}
