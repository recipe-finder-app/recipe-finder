enum HiveBoxEnum {
  userModel,
  materialSearchMap,
  firstOpening,
}

enum HiveKeyEnum {
  user,
  materialSearchMap,
  firstOpening,
}

enum HiveAdapterKeyEnum {
  userAdapter(1),
  ingredientAdapter(2),
  ingredientCategoryAdapter(3),
  ingredientQuantityAdapter(4),
  recipeAdapter(5),
  recipeCategoryAdapter(6);
  

  const HiveAdapterKeyEnum(this.value);
  final int value;
}
