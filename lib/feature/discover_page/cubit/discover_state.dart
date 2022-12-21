abstract class IDiscoverState {
  IDiscoverState();
}

class DiscoverInit extends IDiscoverState {
  DiscoverInit();
}

class DiscoverLoading extends IDiscoverState {
  late bool isLoading;
  DiscoverLoading(isLoading);
}

class ChangeSelectedCategoryIndex extends IDiscoverState {
  int? index;
  ChangeSelectedCategoryIndex(this.index);
}

class DiscoverError extends IDiscoverState {
  String errorMessage;
  DiscoverError(this.errorMessage);
}
