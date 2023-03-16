enum ServicePath {
  base('https://tarifiyle-bul.onrender.com/'),
  login('/api/users/login'),
  register('/api/users/register'),
  resetPassword('/api/passwordreset'),
  categoryOfIngredient('/api/ingredientcategory'),
  ingredientsOfCategory('/api/ingredients/bycategory');

  const ServicePath(this.path);
  final String path;
}
