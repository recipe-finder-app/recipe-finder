class ErrorText {
  static ErrorText instance = ErrorText._init();
  ErrorText._init();

  final noConnectionErrorText = 'İnternet Bağlantısı Yok!';
  final noConnectionErrorExplanationText =
      'İnternet bağlantısı sağlanamadı!Lütfen ağınızı kontrol ediniz.';
  final emptyFieldErrorText = 'Bu alanı boş bırakmayınız!';
}
