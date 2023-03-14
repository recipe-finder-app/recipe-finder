enum ServicePath {
  base('https://tarifiyle-bul.onrender.com/'),
  login('/api/users/login'),
  register('/api/users/register'),
  resetPassword('/api/passwordreset'),
  ingredientCategory('/api/ingredientcategory');

  const ServicePath(this.path);
  final String path;
}
