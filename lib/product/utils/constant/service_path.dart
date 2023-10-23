class ServicePath {
  static const login = '/users/login';
  static const register = '/users/register';
  static const resetPassword = '/passwordreset';
  static const categoryOfIngredient = '/ingredientcategory';
  static const ingredientsOfCategory = '/ingredients/bycategory';
  static const recipeCategory = '/recipecategory';

  static String getAllRecipes(int page, int limit) {
    return '/recipes?page=$page&limit=$limit';
  }
}
