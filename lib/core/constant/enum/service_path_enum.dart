enum ServicePath {
  base('https://tarifiyle-bul.onrender.com/'),
  login('/api/users/login'),
  register('/api/users/register'),
  resetPassword('https://tarifiyle-bul.onrender.com/api/passwordreset');

  const ServicePath(this.path);
  final String path;
}
