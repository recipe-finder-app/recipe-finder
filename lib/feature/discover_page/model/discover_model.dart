import '../../../core/init/language/locale_keys.g.dart';

class DiscoverCategoryItems {
  late final List<String> categories;

  DiscoverCategoryItems() {
    categories = [
      LocaleKeys.all,
      LocaleKeys.breakfast,
      LocaleKeys.lunch,
      LocaleKeys.dinner,
      LocaleKeys.desserts
    ];
  }
}
